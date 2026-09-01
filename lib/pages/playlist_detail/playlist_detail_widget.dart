import '/components/track_item/track_item_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_palette/material_palette.dart';
import 'package:provider/provider.dart';
import 'playlist_detail_model.dart';
export 'playlist_detail_model.dart';

class PlaylistDetailWidget extends StatefulWidget {
  const PlaylistDetailWidget({super.key});

  static String routeName = 'PlaylistDetail';
  static String routePath = '/playlistDetail';

  @override
  State<PlaylistDetailWidget> createState() => _PlaylistDetailWidgetState();
}

class _PlaylistDetailWidgetState extends State<PlaylistDetailWidget> {
  late PlaylistDetailModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlaylistDetailModel());
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
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 100.0),
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 340.0,
                            child: Stack(
                              alignment: AlignmentDirectional(-1.0, -1.0),
                              children: [
                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    return FbmGradientShaderFill(
                                      width: constraints.maxWidth.isFinite
                                          ? constraints.maxWidth
                                          : 200.0,
                                      height: constraints.maxHeight.isFinite
                                          ? constraints.maxHeight
                                          : 200.0,
                                      params: ShaderParams(values: {
                                        'gradientAngle': 180.0,
                                        'gradientScale': 0.89,
                                        'gradientOffset': 0.0,
                                        'noiseIntensity': 0.32,
                                        'ditherStrength': 2.51,
                                        'ditherScale': 0.29,
                                        'animSpeed': 1.46,
                                        'octaves': 6.06,
                                        'lacunarity': 2.35,
                                        'persistence': 0.5,
                                        'noiseScale': 6.36,
                                        'colorCount': 7.0,
                                        'softness': 0.0,
                                        'exposure': 1.0,
                                        'contrast': 1.0,
                                        'bumpStrength': 0.0,
                                        'lightDirX': 0.55,
                                        'lightDirY': 0.45,
                                        'lightDirZ': 1.0,
                                        'lightIntensity': 1.15,
                                        'ambient': 0.7,
                                        'specular': 0.29,
                                        'shininess': 40.76,
                                        'metallic': 1.0,
                                        'roughness': 1.0,
                                        'edgeFade': 1.72,
                                        'edgeFadeMode': 0.0,
                                        'sharpness': 2.2
                                      }, colors: {
                                        'color0': FlutterFlowTheme.of(context)
                                            .primary,
                                        'color1': FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        'color2': FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        'color3': FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        'color4': FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        'color5': FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        'color6': FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        'color7': Color(0x00808080),
                                        'color8': Color(0x00808080),
                                        'color9': Color(0x00808080)
                                      }),
                                      animationMode:
                                          ShaderAnimationMode.continuous,
                                      cache: false,
                                    );
                                  },
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 1.0),
                                  child: Padding(
                                    padding: EdgeInsets.all(24.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          child: Container(
                                            width: 180.0,
                                            height: 180.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: CachedNetworkImage(
                                              fadeInDuration:
                                                  Duration(milliseconds: 0),
                                              fadeOutDuration:
                                                  Duration(milliseconds: 0),
                                              imageUrl:
                                                  'https://dimg.dreamflow.cloud/v1/image/synthwave%20aesthetic%20playlist%20cover%20art',
                                              fit: BoxFit.cover,
                                              alignment: Alignment(0.0, 0.0),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Midnight Synthwave',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .headlineMedium
                                                  .override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineMedium
                                                            .fontStyle,
                                                    lineHeight: 1.3,
                                                  ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 24.0,
                                                  height: 24.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Text(
                                                    'SS',
                                                    textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .roboto(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .onPrimary,
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                          lineHeight: 1.4,
                                                        ),
                                                    overflow: TextOverflow.clip,
                                                  ),
                                                ),
                                                Text(
                                                  'SonicStream • 1,240,502 likes • 4h 20m',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.roboto(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                        lineHeight: 1.4,
                                                      ),
                                                ),
                                              ].divide(SizedBox(width: 8.0)),
                                            ),
                                          ].divide(SizedBox(height: 4.0)),
                                        ),
                                      ].divide(SizedBox(height: 16.0)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FlutterFlowIconButton(
                                      borderRadius: 8.0,
                                      buttonSize: 44.0,
                                      fillColor: Colors.transparent,
                                      icon: Icon(
                                        Icons.favorite_border_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 28.0,
                                      ),
                                      onPressed: () {
                                        print('IconButton pressed ...');
                                      },
                                    ),
                                    FlutterFlowIconButton(
                                      borderRadius: 8.0,
                                      buttonSize: 44.0,
                                      fillColor: Colors.transparent,
                                      icon: Icon(
                                        Icons.download_for_offline_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 28.0,
                                      ),
                                      onPressed: () {
                                        print('IconButton pressed ...');
                                      },
                                    ),
                                    FlutterFlowIconButton(
                                      borderRadius: 8.0,
                                      buttonSize: 44.0,
                                      fillColor: Colors.transparent,
                                      icon: Icon(
                                        Icons.share_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 28.0,
                                      ),
                                      onPressed: () {
                                        print('IconButton pressed ...');
                                      },
                                    ),
                                  ].divide(SizedBox(width: 24.0)),
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
                                        Icons.shuffle_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 24.0,
                                      ),
                                      onPressed: () {
                                        print('IconButton pressed ...');
                                      },
                                    ),
                                    Container(
                                      width: 56.0,
                                      height: 56.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        borderRadius:
                                            BorderRadius.circular(9999.0),
                                        shape: BoxShape.rectangle,
                                      ),
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Icon(
                                        Icons.play_arrow_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .onSecondary,
                                        size: 32.0,
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 16.0)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                wrapWithModel(
                                  model: _model.trackItemModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TrackItemWidget(
                                    artDesc:
                                        'https://dimg.dreamflow.cloud/v1/image/retro%20car%20at%20night',
                                    artist: 'The Midnight',
                                    duration: '4:12',
                                    title: 'Neon Nights',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.trackItemModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TrackItemWidget(
                                    artDesc:
                                        'https://dimg.dreamflow.cloud/v1/image/vaporwave%20grid',
                                    artist: 'Home',
                                    duration: '3:32',
                                    title: 'Resonance',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.trackItemModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TrackItemWidget(
                                    artDesc:
                                        'https://dimg.dreamflow.cloud/v1/image/red%20sports%20car',
                                    artist: 'Kavinsky',
                                    duration: '4:18',
                                    title: 'Nightcall',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.trackItemModel4,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TrackItemWidget(
                                    artDesc:
                                        'https://dimg.dreamflow.cloud/v1/image/red%20suit%20portrait',
                                    artist: 'The Weeknd',
                                    duration: '3:20',
                                    title: 'Blinding Lights',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.trackItemModel5,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TrackItemWidget(
                                    artDesc:
                                        'https://dimg.dreamflow.cloud/v1/image/dark%20aesthetic%20anime',
                                    artist: 'Mr.Kitty',
                                    duration: '3:54',
                                    title: 'After Dark',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.trackItemModel6,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TrackItemWidget(
                                    artDesc:
                                        'https://dimg.dreamflow.cloud/v1/image/ocean%20drive',
                                    artist: 'TWRP',
                                    duration: '4:45',
                                    title: 'Pacific Coast Highway',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.trackItemModel7,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TrackItemWidget(
                                    artDesc:
                                        'https://dimg.dreamflow.cloud/v1/image/masked%20figure',
                                    artist: 'Carpenter Brut',
                                    duration: '4:04',
                                    title: 'Turbo Killer',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.trackItemModel8,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TrackItemWidget(
                                    artDesc:
                                        'https://dimg.dreamflow.cloud/v1/image/cyberpunk%20city',
                                    artist: 'Gunship',
                                    duration: '5:02',
                                    title: 'Tech Noir',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.trackItemModel9,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TrackItemWidget(
                                    artDesc:
                                        'https://dimg.dreamflow.cloud/v1/image/psychedelic%20art',
                                    artist: 'Tame Impala',
                                    duration: '3:38',
                                    title: 'The Less I Know The Better',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.trackItemModel10,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TrackItemWidget(
                                    artDesc:
                                        'https://dimg.dreamflow.cloud/v1/image/blue%20neon%20face',
                                    artist: 'The Weeknd',
                                    duration: '3:50',
                                    title: 'Starboy',
                                  ),
                                ),
                              ].divide(SizedBox(height: 8.0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, -1.0),
              child: Container(
                height: 100.0,
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(24.0, 40.0, 24.0, 0.0),
                  child: Container(
                    child: Container(
                      height: 60.0,
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 9999.0,
                            buttonSize: 40.0,
                            fillColor: FlutterFlowTheme.of(context).surface80,
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                          FlutterFlowIconButton(
                            borderRadius: 9999.0,
                            buttonSize: 40.0,
                            fillColor: FlutterFlowTheme.of(context).surface80,
                            icon: Icon(
                              Icons.search_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 1.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  alignment: AlignmentDirectional(0.0, 1.0),
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
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Container(
                        child: Container(
                          height: 48.0,
                          alignment: AlignmentDirectional(0.0, 0.0),
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
                                    fadeOutDuration: Duration(milliseconds: 0),
                                    imageUrl:
                                        'https://dimg.dreamflow.cloud/v1/image/synthwave%20album%20art',
                                    fit: BoxFit.cover,
                                    alignment: Alignment(0.0, 0.0),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Neon Nights',
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.roboto(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                            lineHeight: 1.5,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      'The Midnight',
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
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
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
                                    ),
                                  ],
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
                                    buttonSize: 48.0,
                                    fillColor: Colors.transparent,
                                    icon: Icon(
                                      Icons.pause_circle_filled_rounded,
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
