import '/components/category_chip/category_chip_widget.dart';
import '/components/library_item/library_item_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'your_library_model.dart';
export 'your_library_model.dart';

class YourLibraryWidget extends StatefulWidget {
  const YourLibraryWidget({super.key});

  static String routeName = 'YourLibrary';
  static String routePath = '/yourLibrary';

  @override
  State<YourLibraryWidget> createState() => _YourLibraryWidgetState();
}

class _YourLibraryWidgetState extends State<YourLibraryWidget> {
  late YourLibraryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => YourLibraryModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Stack(
          alignment: AlignmentDirectional(-1.0, -1.0),
          children: [
            SingleChildScrollView(
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 32.0,
                                    height: 32.0,
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Text(
                                      'JD',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .onPrimary,
                                            fontSize: 12.16,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                            lineHeight: 1.4,
                                          ),
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                  Text(
                                    'Your Library',
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          font: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w800,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .headlineMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .headlineMedium
                                                  .fontStyle,
                                          lineHeight: 1.3,
                                        ),
                                  ),
                                ].divide(SizedBox(width: 16.0)),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FlutterFlowIconButton(
                                    borderRadius: 8.0,
                                    buttonSize: 40.0,
                                    fillColor: Colors.transparent,
                                    icon: Icon(
                                      Icons.search_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
                                    ),
                                    onPressed: () {
                                      print('IconButton pressed ...');
                                    },
                                  ),
                                  FlutterFlowIconButton(
                                    borderRadius: 8.0,
                                    buttonSize: 40.0,
                                    fillColor: Colors.transparent,
                                    icon: Icon(
                                      Icons.add_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
                                    ),
                                    onPressed: () {
                                      print('IconButton pressed ...');
                                    },
                                  ),
                                ].divide(SizedBox(width: 8.0)),
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                wrapWithModel(
                                  model: _model.categoryChipModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: CategoryChipWidget(
                                    label: 'Playlists',
                                    selected: true,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.categoryChipModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: CategoryChipWidget(
                                    label: 'Artists',
                                    selected: false,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.categoryChipModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: CategoryChipWidget(
                                    label: 'Albums',
                                    selected: false,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.categoryChipModel4,
                                  updateCallback: () => safeSetState(() {}),
                                  child: CategoryChipWidget(
                                    label: 'Podcasts',
                                    selected: false,
                                  ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.swap_vert_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 16.0,
                                  ),
                                  Text(
                                    'Recents',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          font: GoogleFonts.roboto(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                ].divide(SizedBox(width: 4.0)),
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 40.0,
                                fillColor: Colors.transparent,
                                icon: Icon(
                                  Icons.grid_view_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 20.0,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              wrapWithModel(
                                model: _model.libraryItemModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: LibraryItemWidget(
                                  imgDesc:
                                      'https://dimg.dreamflow.cloud/v1/image/heart%20icon%20neon%20green%20music',
                                  isActive: true,
                                  subtitle: 'Playlist • 428 songs',
                                  title: 'Liked Songs',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.libraryItemModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: LibraryItemWidget(
                                  imgDesc:
                                      'https://dimg.dreamflow.cloud/v1/image/minimalist%20study%20room%20lofi',
                                  isActive: false,
                                  subtitle: 'Playlist • SonicStream',
                                  title: 'Deep Focus',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.libraryItemModel3,
                                updateCallback: () => safeSetState(() {}),
                                child: LibraryItemWidget(
                                  imgDesc:
                                      'https://dimg.dreamflow.cloud/v1/image/modern%20pop%20star%20portrait',
                                  isActive: false,
                                  subtitle: 'Artist',
                                  title: 'The Weeknd',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.libraryItemModel4,
                                updateCallback: () => safeSetState(() {}),
                                child: LibraryItemWidget(
                                  imgDesc:
                                      'https://dimg.dreamflow.cloud/v1/image/red%20suit%20aesthetic%20album%20cover',
                                  isActive: false,
                                  subtitle: 'Album • The Weeknd',
                                  title: 'After Hours',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.libraryItemModel5,
                                updateCallback: () => safeSetState(() {}),
                                child: LibraryItemWidget(
                                  imgDesc:
                                      'https://dimg.dreamflow.cloud/v1/image/dark%20warehouse%20neon%20lights',
                                  isActive: false,
                                  subtitle: 'Playlist • Hardstyle',
                                  title: 'Techno Bunker',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.libraryItemModel6,
                                updateCallback: () => safeSetState(() {}),
                                child: LibraryItemWidget(
                                  imgDesc:
                                      'https://dimg.dreamflow.cloud/v1/image/orchestra%20conductor%20portrait',
                                  isActive: false,
                                  subtitle: 'Artist',
                                  title: 'Hans Zimmer',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.libraryItemModel7,
                                updateCallback: () => safeSetState(() {}),
                                child: LibraryItemWidget(
                                  imgDesc:
                                      'https://dimg.dreamflow.cloud/v1/image/space%20galaxy%20nebula',
                                  isActive: false,
                                  subtitle: 'Album • Hans Zimmer',
                                  title: 'Interstellar OST',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.libraryItemModel8,
                                updateCallback: () => safeSetState(() {}),
                                child: LibraryItemWidget(
                                  imgDesc:
                                      'https://dimg.dreamflow.cloud/v1/image/steaming%20coffee%20cup%20morning%20sun',
                                  isActive: false,
                                  subtitle: 'Playlist • Chill Hop',
                                  title: 'Morning Coffee',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.libraryItemModel9,
                                updateCallback: () => safeSetState(() {}),
                                child: LibraryItemWidget(
                                  imgDesc:
                                      'https://dimg.dreamflow.cloud/v1/image/robot%20helmets%20chrome',
                                  isActive: false,
                                  subtitle: 'Artist',
                                  title: 'Daft Punk',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.libraryItemModel10,
                                updateCallback: () => safeSetState(() {}),
                                child: LibraryItemWidget(
                                  imgDesc:
                                      'https://dimg.dreamflow.cloud/v1/image/metallic%20rainbow%20logo',
                                  isActive: false,
                                  subtitle: 'Album • Daft Punk',
                                  title: 'Random Access Memories',
                                ),
                              ),
                            ].divide(SizedBox(height: 16.0)),
                          ),
                          Container(
                            height: 100.0,
                          ),
                        ].divide(SizedBox(height: 24.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 1.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Container(
                      height: 80.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(12.0),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 1.0,
                        ),
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional(-1.0, -1.0),
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  FlutterFlowTheme.of(context).primary,
                                  FlutterFlowTheme.of(context).primaryBackground
                                ],
                                stops: [0.0, 1.0],
                                begin: AlignmentDirectional(-1.0, 0.0),
                                end: AlignmentDirectional(1.0, 0),
                              ),
                              shape: BoxShape.rectangle,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4.0),
                                  child: Container(
                                    width: 48.0,
                                    height: 48.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: CachedNetworkImage(
                                      fadeInDuration: Duration(milliseconds: 0),
                                      fadeOutDuration:
                                          Duration(milliseconds: 0),
                                      imageUrl:
                                          'https://dimg.dreamflow.cloud/v1/image/blinding%20lights%20the%20weeknd%20album%20cover',
                                      fit: BoxFit.cover,
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Blinding Lights',
                                        maxLines: 1,
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              font: GoogleFonts.roboto(
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                              lineHeight: 1.5,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'The Weeknd',
                                        maxLines: 1,
                                        style: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .override(
                                              font: GoogleFonts.roboto(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontStyle,
                                              lineHeight: 1.3,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ].divide(SizedBox(height: 2.0)),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FlutterFlowIconButton(
                                      borderRadius: 8.0,
                                      buttonSize: 40.0,
                                      fillColor: Colors.transparent,
                                      icon: Icon(
                                        Icons.devices_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 20.0,
                                      ),
                                      onPressed: () {
                                        print('IconButton pressed ...');
                                      },
                                    ),
                                    FlutterFlowIconButton(
                                      borderRadius: 8.0,
                                      buttonSize: 40.0,
                                      fillColor: Colors.transparent,
                                      icon: Icon(
                                        Icons.favorite_border_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 22.0,
                                      ),
                                      onPressed: () {
                                        print('IconButton pressed ...');
                                      },
                                    ),
                                    FlutterFlowIconButton(
                                      borderRadius: 8.0,
                                      buttonSize: 48.0,
                                      fillColor: Colors.transparent,
                                      icon: Icon(
                                        Icons.play_arrow_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 32.0,
                                      ),
                                      onPressed: () {
                                        print('IconButton pressed ...');
                                      },
                                    ),
                                  ].divide(SizedBox(width: 8.0)),
                                ),
                              ].divide(SizedBox(width: 16.0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
