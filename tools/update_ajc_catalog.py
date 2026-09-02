#!/usr/bin/env python3
"""Actualiza de forma incremental los catálogos de AJC Player.

Consulta la API oficial de metadatos de Internet Archive, descarga solamente
los conciertos que aún no están en el índice local y reconstruye:

* _index_todos_los_conciertos.json
* index_artists_clean.json
* index_artists_genres_final_clean.json

Los conciertos locales nunca se eliminan aunque dejen de aparecer en la
búsqueda de Internet Archive. Los géneros y demás metadatos ya clasificados
también se conservan. Los artistas nuevos quedan como ``Other`` y con estado
``pending`` para poder clasificarlos más adelante.
"""

from __future__ import annotations

import argparse
import concurrent.futures
import json
import os
import re
import shutil
import sys
import tempfile
import time
import unicodedata
from collections import defaultdict
from pathlib import Path
from typing import Any
from urllib.error import HTTPError, URLError
from urllib.parse import quote, urlencode
from urllib.request import Request, urlopen


SEARCH_URL = "https://archive.org/advancedsearch.php"
METADATA_URL = "https://archive.org/metadata/{identifier}"
DETAIL_URL = "https://archive.org/details/{identifier}"
DOWNLOAD_URL = "https://archive.org/download/{identifier}/{filename}"
COLLECTION_QUERY = 'collection:"aadamjacobs" AND identifier:ajc*'
USER_AGENT = "AJC-Player-Catalog-Updater/1.0"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Descarga conciertos nuevos y reconstruye los JSON de AJC Player."
    )
    parser.add_argument(
        "--concerts",
        required=True,
        type=Path,
        help="Índice actual _index_todos_los_conciertos.json",
    )
    parser.add_argument(
        "--artists-clean",
        required=True,
        type=Path,
        help="Índice actual index_artists_clean.json",
    )
    parser.add_argument(
        "--artists-genres",
        required=True,
        type=Path,
        help="Índice actual index_artists_genres_final_clean.json",
    )
    parser.add_argument(
        "--output-dir",
        type=Path,
        default=Path("catalog_update"),
        help="Carpeta de salida (por defecto: catalog_update)",
    )
    parser.add_argument(
        "--workers",
        type=int,
        default=6,
        help="Descargas simultáneas, entre 1 y 12 (por defecto: 6)",
    )
    parser.add_argument(
        "--refresh-empty",
        action="store_true",
        help="Vuelve a consultar conciertos existentes que no tienen canciones",
    )
    parser.add_argument(
        "--sync-app-asset",
        type=Path,
        help="Copia el índice final de géneros a este asset después de validarlo",
    )
    parser.add_argument(
        "--limit",
        type=int,
        help="Procesa como máximo N elementos (solo para pruebas)",
    )
    return parser.parse_args()


def read_json(path: Path) -> Any:
    with path.open("r", encoding="utf-8") as handle:
        return json.load(handle)


def atomic_write_json(path: Path, value: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    fd, temporary_name = tempfile.mkstemp(
        prefix=f".{path.name}.", suffix=".tmp", dir=path.parent
    )
    try:
        with os.fdopen(fd, "w", encoding="utf-8") as handle:
            json.dump(value, handle, ensure_ascii=False, indent=2)
            handle.write("\n")
        os.replace(temporary_name, path)
        path.chmod(0o644)
    except BaseException:
        try:
            os.unlink(temporary_name)
        except FileNotFoundError:
            pass
        raise


def fetch_json(url: str, *, attempts: int = 5, timeout: int = 60) -> Any:
    last_error: Exception | None = None
    for attempt in range(1, attempts + 1):
        try:
            request = Request(url, headers={"User-Agent": USER_AGENT})
            with urlopen(request, timeout=timeout) as response:
                return json.loads(response.read().decode("utf-8"))
        except (HTTPError, URLError, TimeoutError, json.JSONDecodeError) as error:
            last_error = error
            if attempt == attempts:
                break
            time.sleep(min(2 ** (attempt - 1), 12))
    raise RuntimeError(f"No se pudo descargar {url}: {last_error}")


def fetch_remote_identifiers() -> list[str]:
    params = urlencode(
        [
            ("q", COLLECTION_QUERY),
            ("fl[]", "identifier"),
            ("sort[]", "identifier asc"),
            ("rows", "5000"),
            ("page", "1"),
            ("output", "json"),
        ]
    )
    payload = fetch_json(f"{SEARCH_URL}?{params}")
    response = payload.get("response", {})
    identifiers = [
        str(item["identifier"])
        for item in response.get("docs", [])
        if item.get("identifier")
    ]
    expected = int(response.get("numFound", len(identifiers)))
    if expected != len(identifiers):
        raise RuntimeError(
            f"La búsqueda anuncia {expected} elementos, pero devolvió {len(identifiers)}."
        )
    return identifiers


def scalar(value: Any) -> str:
    if isinstance(value, list):
        return str(value[0]).strip() if value else ""
    return str(value or "").strip()


def normalize_artist(value: str) -> str:
    return " ".join(value.casefold().split())


def unique_normalized_artist_names(
    artists: list[dict[str, Any]],
) -> dict[str, str]:
    """Devuelve solo equivalencias normalizadas que no sean ambiguas."""
    candidates: dict[str, set[str]] = defaultdict(set)
    for artist in artists:
        name = scalar(artist.get("artista"))
        if name:
            candidates[normalize_artist(name)].add(name)
    return {
        normalized: next(iter(names))
        for normalized, names in candidates.items()
        if len(names) == 1
    }


def artist_from_title(title: str) -> str:
    parts = re.split(r"\s+Live\b", title, maxsplit=1, flags=re.IGNORECASE)
    return parts[0].strip() if parts else title.strip()


def date_only(value: Any) -> str:
    match = re.search(r"\d{4}-\d{2}-\d{2}", scalar(value))
    return match.group(0) if match else ""


def seconds_from_length(value: Any) -> int:
    text = scalar(value)
    if not text:
        return 0
    try:
        return max(0, round(float(text)))
    except ValueError:
        pass
    pieces = text.split(":")
    try:
        numbers = [float(piece) for piece in pieces]
    except ValueError:
        return 0
    if len(numbers) == 2:
        return max(0, round(numbers[0] * 60 + numbers[1]))
    if len(numbers) == 3:
        return max(0, round(numbers[0] * 3600 + numbers[1] * 60 + numbers[2]))
    return 0


def display_duration(seconds: int) -> str:
    hours, remainder = divmod(seconds, 3600)
    minutes, seconds_part = divmod(remainder, 60)
    if hours:
        return f"{hours:02d}:{minutes:02d}:{seconds_part:02d}"
    return f"{minutes:02d}:{seconds_part:02d}"


def track_sort_key(file_data: dict[str, Any]) -> tuple[int, str]:
    track = scalar(file_data.get("track"))
    match = re.search(r"\d+", track)
    if match:
        return int(match.group(0)), scalar(file_data.get("name")).casefold()
    name = scalar(file_data.get("name"))
    matches = re.findall(r"(?:^|[_-])t?(\d{1,3})(?=\D|$)", name, re.IGNORECASE)
    return (int(matches[-1]) if matches else 999999), name.casefold()


def songs_from_files(identifier: str, files: list[Any]) -> list[dict[str, str]]:
    mp3_files = [
        item
        for item in files
        if isinstance(item, dict)
        and scalar(item.get("name")).lower().endswith(".mp3")
        and not scalar(item.get("name")).startswith("__")
    ]
    mp3_files.sort(key=track_sort_key)
    songs: list[dict[str, str]] = []
    seen_urls: set[str] = set()
    for position, item in enumerate(mp3_files, start=1):
        filename = scalar(item.get("name"))
        mp3_url = DOWNLOAD_URL.format(
            identifier=quote(identifier, safe=""), filename=quote(filename, safe="")
        )
        if mp3_url in seen_urls:
            continue
        seen_urls.add(mp3_url)
        seconds = seconds_from_length(item.get("length"))
        name = scalar(item.get("title"))
        if not name:
            track = scalar(item.get("track")) or f"{position:02d}"
            name = f"Track {track}"
        songs.append(
            {
                "nombre": name,
                "duracion": display_duration(seconds),
                "duracion_iso": f"PT0M{seconds}S",
                "mp3": mp3_url,
            }
        )
    return songs


def concert_from_metadata(
    identifier: str, canonical_artists: dict[str, str]
) -> dict[str, Any]:
    payload = fetch_json(METADATA_URL.format(identifier=quote(identifier, safe="")))
    metadata = payload.get("metadata") or {}
    title = scalar(metadata.get("title"))
    artist = scalar(metadata.get("creator")) or artist_from_title(title)
    artist = canonical_artists.get(normalize_artist(artist), artist)
    publication_date = date_only(metadata.get("date"))
    if not publication_date:
        publication_date = date_only(title)
    return {
        "identifier": identifier,
        "url": DETAIL_URL.format(identifier=identifier),
        "concierto": title or identifier,
        "artista": artist,
        "fecha_publicacion": publication_date,
        "imagen_disco": DOWNLOAD_URL.format(
            identifier=quote(identifier, safe=""), filename="__ia_thumb.jpg"
        ),
        "canciones": songs_from_files(identifier, payload.get("files") or []),
    }


def safe_filename(identifier: str) -> str:
    return re.sub(r"[^a-zA-Z0-9._-]", "_", identifier)


def slug_for_artist(name: str) -> str:
    normalized = unicodedata.normalize("NFKD", name)
    ascii_name = normalized.encode("ascii", "ignore").decode("ascii")
    slug = re.sub(r"[^a-zA-Z0-9]+", "-", ascii_name.casefold()).strip("-")
    return slug or "artist"


def concert_summary(concert: dict[str, Any]) -> dict[str, Any]:
    identifier = scalar(concert.get("identifier"))
    publication_date = scalar(concert.get("fecha_publicacion"))
    songs = concert.get("canciones")
    if not isinstance(songs, list):
        songs = []
    return {
        "identifier": identifier,
        "concierto": scalar(concert.get("concierto")),
        "fecha_publicacion": publication_date,
        "year": publication_date[:4],
        "imagen_disco": scalar(concert.get("imagen_disco")),
        "tracks_count": len(songs),
        "json_file": f"concerts/{safe_filename(identifier)}.json",
        "url": scalar(concert.get("url")),
    }


def build_artist_indexes(
    concerts: list[dict[str, Any]],
    clean_source: list[dict[str, Any]],
    genres_source: list[dict[str, Any]],
) -> tuple[list[dict[str, Any]], list[dict[str, Any]]]:
    grouped: dict[str, list[dict[str, Any]]] = defaultdict(list)
    for concert in concerts:
        raw_name = scalar(concert.get("artista")) or "Unknown Artist"
        grouped[raw_name].append(concert_summary(concert))

    clean_by_exact_name = {
        scalar(item.get("artista")): item for item in clean_source
    }
    genres_by_exact_name = {
        scalar(item.get("artista")): item for item in genres_source
    }
    unique_clean_names = unique_normalized_artist_names(clean_source)
    unique_genre_names = unique_normalized_artist_names(genres_source)
    clean_output: list[dict[str, Any]] = []
    genres_output: list[dict[str, Any]] = []

    for name in sorted(grouped, key=str.casefold):
        key = normalize_artist(name)
        summaries = sorted(
            grouped[name],
            key=lambda item: (
                scalar(item.get("fecha_publicacion")),
                scalar(item.get("identifier")),
            ),
        )
        previous_clean = clean_by_exact_name.get(name)
        if previous_clean is None and key in unique_clean_names:
            previous_clean = clean_by_exact_name[unique_clean_names[key]]
        previous_clean = previous_clean or {}
        base = {
            "artista": name,
            "artist_slug": scalar(previous_clean.get("artist_slug"))
            or slug_for_artist(name),
            "total_concerts": len(summaries),
            "concerts": summaries,
        }
        clean_output.append(base)

        previous_genres = genres_by_exact_name.get(name)
        if previous_genres is None and key in unique_genre_names:
            previous_genres = genres_by_exact_name[unique_genre_names[key]]
        if previous_genres:
            enriched = {
                field: value
                for field, value in previous_genres.items()
                if field not in {"artista", "artist_slug", "total_concerts", "concerts"}
            }
            enriched = {**base, **enriched}
        else:
            enriched = {
                **base,
                "genres": [],
                "primary_genre": "Other",
                "genre_status": "pending",
            }
        enriched.pop("genre_source", None)
        genres_output.append(enriched)

    return clean_output, genres_output


def validate_catalogs(
    original_ids: set[str],
    concerts: list[dict[str, Any]],
    clean_artists: list[dict[str, Any]],
    genre_artists: list[dict[str, Any]],
) -> dict[str, int]:
    identifiers = [scalar(item.get("identifier")) for item in concerts]
    if any(not identifier for identifier in identifiers):
        raise ValueError("Hay conciertos sin identifier.")
    if len(identifiers) != len(set(identifiers)):
        raise ValueError("El índice final contiene identifiers duplicados.")
    missing_original = original_ids - set(identifiers)
    if missing_original:
        raise ValueError(
            f"Se perderían {len(missing_original)} conciertos existentes; no se guardará nada."
        )

    for label, artists in (
        ("clean", clean_artists),
        ("genres", genre_artists),
    ):
        indexed_ids = [
            scalar(concert.get("identifier"))
            for artist in artists
            for concert in artist.get("concerts", [])
        ]
        if len(indexed_ids) != len(identifiers) or set(indexed_ids) != set(identifiers):
            raise ValueError(f"El índice de artistas {label} no coincide con los conciertos.")
        if any(artist.get("total_concerts") != len(artist.get("concerts", [])) for artist in artists):
            raise ValueError(f"Hay total_concerts incorrectos en el índice {label}.")

    pending = sum(
        1 for artist in genre_artists if artist.get("genre_status") == "pending"
    )
    empty = sum(1 for concert in concerts if not concert.get("canciones"))
    return {
        "concerts": len(concerts),
        "artists": len(clean_artists),
        "pending_genres": pending,
        "concerts_without_songs": empty,
    }


def load_or_download(
    identifier: str,
    cache_dir: Path,
    canonical_artists: dict[str, str],
) -> tuple[str, dict[str, Any] | None, str | None]:
    cache_path = cache_dir / f"{safe_filename(identifier)}.json"
    if cache_path.exists():
        try:
            return identifier, read_json(cache_path), None
        except (OSError, json.JSONDecodeError):
            pass
    try:
        concert = concert_from_metadata(identifier, canonical_artists)
        atomic_write_json(cache_path, concert)
        return identifier, concert, None
    except Exception as error:  # la descarga de un item no invalida los demás
        return identifier, None, str(error)


def main() -> int:
    args = parse_args()
    args.workers = max(1, min(args.workers, 12))

    concerts = read_json(args.concerts)
    clean_artists = read_json(args.artists_clean)
    genre_artists = read_json(args.artists_genres)
    if not all(isinstance(value, list) for value in (concerts, clean_artists, genre_artists)):
        raise ValueError("Los tres archivos de entrada deben contener listas JSON.")

    original_ids = {
        scalar(item.get("identifier")) for item in concerts if item.get("identifier")
    }
    if len(original_ids) != len(concerts):
        raise ValueError("El índice de conciertos de entrada ya contiene duplicados o IDs vacíos.")

    print(f"Conciertos locales: {len(concerts)}")
    print("Consultando la colección de Internet Archive...")
    remote_ids = fetch_remote_identifiers()
    remote_set = set(remote_ids)
    new_ids = sorted(remote_set - original_ids)
    preserved_ids = sorted(original_ids - remote_set)

    refresh_ids: list[str] = []
    if args.refresh_empty:
        refresh_ids = sorted(
            scalar(item.get("identifier"))
            for item in concerts
            if not item.get("canciones") and item.get("identifier") in remote_set
        )

    targets = new_ids + [identifier for identifier in refresh_ids if identifier not in new_ids]
    if args.limit is not None:
        targets = targets[: max(0, args.limit)]

    print(f"Conciertos remotos: {len(remote_ids)}")
    print(f"Nuevos encontrados: {len(new_ids)}")
    print(f"Conciertos locales ausentes en la búsqueda, pero conservados: {len(preserved_ids)}")
    if args.refresh_empty:
        print(f"Conciertos sin canciones que se intentarán reparar: {len(refresh_ids)}")
    if args.limit is not None:
        print(f"Límite de prueba: {len(targets)} elementos")

    output_dir = args.output_dir.resolve()
    cache_dir = output_dir / ".new_concert_cache"
    cache_dir.mkdir(parents=True, exist_ok=True)

    canonical_artists = unique_normalized_artist_names(genre_artists)
    downloaded: dict[str, dict[str, Any]] = {}
    errors: list[tuple[str, str]] = []
    if targets:
        print(f"Descargando {len(targets)} metadatos con {args.workers} conexiones...")
        with concurrent.futures.ThreadPoolExecutor(max_workers=args.workers) as executor:
            futures = {
                executor.submit(
                    load_or_download, identifier, cache_dir, canonical_artists
                ): identifier
                for identifier in targets
            }
            completed = 0
            for future in concurrent.futures.as_completed(futures):
                identifier, concert, error = future.result()
                completed += 1
                if concert is not None:
                    downloaded[identifier] = concert
                else:
                    errors.append((identifier, error or "Error desconocido"))
                if completed % 25 == 0 or completed == len(targets):
                    print(f"  {completed}/{len(targets)} procesados")

    by_id = {scalar(item.get("identifier")): item for item in concerts}
    refreshed = 0
    added = 0
    for identifier, concert in downloaded.items():
        if identifier in by_id:
            # Solo sustituye un registro vacío cuando la API aporta canciones.
            if concert.get("canciones"):
                # Conserva literalmente todos los campos antiguos. Únicamente
                # incorpora las pistas recuperadas y rellena campos que antes
                # estuvieran vacíos.
                merged = dict(by_id[identifier])
                merged["canciones"] = concert["canciones"]
                for field in (
                    "url",
                    "concierto",
                    "artista",
                    "fecha_publicacion",
                    "imagen_disco",
                ):
                    if not merged.get(field) and concert.get(field):
                        merged[field] = concert[field]
                by_id[identifier] = merged
                refreshed += 1
        else:
            by_id[identifier] = concert
            added += 1

    original_order = [scalar(item.get("identifier")) for item in concerts]
    appended_ids = sorted(set(by_id) - original_ids)
    final_concerts = [by_id[identifier] for identifier in original_order + appended_ids]
    final_clean, final_genres = build_artist_indexes(
        final_concerts, clean_artists, genre_artists
    )
    summary = validate_catalogs(original_ids, final_concerts, final_clean, final_genres)

    outputs = {
        "_index_todos_los_conciertos.json": final_concerts,
        "index_artists_clean.json": final_clean,
        "index_artists_genres_final_clean.json": final_genres,
    }
    for filename, value in outputs.items():
        atomic_write_json(output_dir / filename, value)

    report = {
        "original_concerts": len(concerts),
        "remote_concerts": len(remote_ids),
        "new_candidates": len(new_ids),
        "new_concerts_added": added,
        "empty_concerts_refreshed": refreshed,
        "download_errors": len(errors),
        "preserved_not_in_remote_search": len(preserved_ids),
        **summary,
        "errors": [
            {"identifier": identifier, "error": error}
            for identifier, error in sorted(errors)
        ],
    }
    atomic_write_json(output_dir / "update_report.json", report)

    if args.sync_app_asset:
        asset_path = args.sync_app_asset.resolve()
        asset_path.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(output_dir / "index_artists_genres_final_clean.json", asset_path)
        print(f"Asset actualizado: {asset_path}")

    print("\nActualización validada y terminada.")
    print(f"Nuevos añadidos: {added}")
    print(f"Conciertos vacíos reparados: {refreshed}")
    print(f"Errores de descarga: {len(errors)}")
    print(f"Total final: {summary['concerts']} conciertos")
    print(f"Artistas finales: {summary['artists']}")
    print(f"Artistas nuevos pendientes de género: {summary['pending_genres']}")
    print(f"Salida: {output_dir}")
    return 0 if not errors else 2


if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        print("\nInterrumpido. La caché permite continuar más tarde.", file=sys.stderr)
        sys.exit(130)
    except Exception as error:
        print(f"ERROR: {error}", file=sys.stderr)
        sys.exit(1)
