import '/components/genre_tile/genre_tile_widget.dart';
import '/components/recent_search/recent_search_widget.dart';
import '/components/text_field/text_field_widget.dart';
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
import 'search_explore_model.dart';
export 'search_explore_model.dart';

class SearchExploreWidget extends StatefulWidget {
  const SearchExploreWidget({super.key});

  static String routeName = 'SearchExplore';
  static String routePath = '/searchExplore';

  @override
  State<SearchExploreWidget> createState() => _SearchExploreWidgetState();
}

class _SearchExploreWidgetState extends State<SearchExploreWidget> {
  late SearchExploreModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchExploreModel());
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
                    'color0': FlutterFlowTheme.of(context).primaryBackground,
                    'color1': FlutterFlowTheme.of(context).primaryBackground,
                    'color2': Color(0x1A1DB954),
                    'color3': FlutterFlowTheme.of(context).primaryBackground,
                    'color4': FlutterFlowTheme.of(context).primaryBackground,
                    'color5': FlutterFlowTheme.of(context).primaryBackground,
                    'color6': FlutterFlowTheme.of(context).primaryBackground,
                    'color7': Color(0x00808080),
                    'color8': Color(0x00808080),
                    'color9': Color(0x00808080)
                  }),
                  animationMode: ShaderAnimationMode.continuous,
                  cache: false,
                );
              },
            ),
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Search',
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontStyle,
                                      lineHeight: 1.3,
                                    ),
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 40.0,
                                fillColor: Colors.transparent,
                                icon: Icon(
                                  Icons.settings_voice_rounded,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 24.0,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                            ],
                          ),
                          wrapWithModel(
                            model: _model.textFieldModel,
                            updateCallback: () => safeSetState(() {}),
                            child: TextFieldWidget(
                              label: '',
                              labelPresent: false,
                              helper: '',
                              helperPresent: false,
                              leadingIcon: Icon(
                                Icons.search_rounded,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                              leadingIconPresent: true,
                              trailingIconPresent: false,
                              hint: 'What do you want to listen to?',
                              value: '',
                              onChange: '',
                              onSubmit: '',
                              variant: 'filled',
                              error: false,
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Recent searches',
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          font: GoogleFonts.roboto(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                          lineHeight: 1.45,
                                        ),
                                  ),
                                  Text(
                                    'Clear all',
                                    style: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .override(
                                          font: GoogleFonts.roboto(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  wrapWithModel(
                                    model: _model.recentSearchModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: RecentSearchWidget(
                                      imgDesc:
                                          'https://dimg.dreamflow.cloud/v1/image/80s%20synthwave%20album%20cover',
                                      subtitle: 'Song • The Weeknd',
                                      title: 'Blinding Lights',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.recentSearchModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: RecentSearchWidget(
                                      imgDesc:
                                          'https://dimg.dreamflow.cloud/v1/image/anime%20girl%20studying%20lofi',
                                      subtitle: 'Playlist • Lofi Hip Hop Radio',
                                      title: 'Lofi Girl',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.recentSearchModel3,
                                    updateCallback: () => safeSetState(() {}),
                                    child: RecentSearchWidget(
                                      imgDesc:
                                          'https://dimg.dreamflow.cloud/v1/image/indie%20rock%20band%20portrait',
                                      subtitle: 'Artist',
                                      title: 'Arctic Monkeys',
                                    ),
                                  ),
                                ].divide(SizedBox(height: 8.0)),
                              ),
                            ].divide(SizedBox(height: 16.0)),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Browse all',
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                      lineHeight: 1.45,
                                    ),
                              ),
                              GridView(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16.0,
                                  mainAxisSpacing: 16.0,
                                  childAspectRatio: 1.5,
                                ),
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                children: [
                                  wrapWithModel(
                                    model: _model.genreTileModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: GenreTileWidget(
                                      color: Color(0xFFE13300),
                                      imgDesc:
                                          'https://dimg.dreamflow.cloud/v1/image/microphone%20studio',
                                      title: 'Podcasts',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.genreTileModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: GenreTileWidget(
                                      color: Color(0xFF1E3264),
                                      imgDesc:
                                          'https://dimg.dreamflow.cloud/v1/image/colorful%20abstract%20shapes',
                                      title: 'Made For You',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.genreTileModel3,
                                    updateCallback: () => safeSetState(() {}),
                                    child: GenreTileWidget(
                                      color: Color(0xFF8D67AB),
                                      imgDesc:
                                          'https://dimg.dreamflow.cloud/v1/image/music%20chart%20ranking',
                                      title: 'Charts',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.genreTileModel4,
                                    updateCallback: () => safeSetState(() {}),
                                    child: GenreTileWidget(
                                      color: Color(0xFFE8115B),
                                      imgDesc:
                                          'https://dimg.dreamflow.cloud/v1/image/vinyl%20record%20spinning',
                                      title: 'New Releases',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.genreTileModel5,
                                    updateCallback: () => safeSetState(() {}),
                                    child: GenreTileWidget(
                                      color: Color(0xFF148A08),
                                      imgDesc:
                                          'https://dimg.dreamflow.cloud/v1/image/pop%20star%20singer',
                                      title: 'Pop',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.genreTileModel6,
                                    updateCallback: () => safeSetState(() {}),
                                    child: GenreTileWidget(
                                      color: Color(0xFFBC5900),
                                      imgDesc:
                                          'https://dimg.dreamflow.cloud/v1/image/graffiti%20wall%20urban',
                                      title: 'Hip-Hop',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.genreTileModel7,
                                    updateCallback: () => safeSetState(() {}),
                                    child: GenreTileWidget(
                                      color: FlutterFlowTheme.of(context).error,
                                      imgDesc:
                                          'https://dimg.dreamflow.cloud/v1/image/electric%20guitar%20close%20up',
                                      title: 'Rock',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.genreTileModel8,
                                    updateCallback: () => safeSetState(() {}),
                                    child: GenreTileWidget(
                                      color: Color(0xFFE1118C),
                                      imgDesc:
                                          'https://dimg.dreamflow.cloud/v1/image/chill%20sunset%20vibes',
                                      title: 'Mood',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.genreTileModel9,
                                    updateCallback: () => safeSetState(() {}),
                                    child: GenreTileWidget(
                                      color: Color(0xFF777777),
                                      imgDesc:
                                          'https://dimg.dreamflow.cloud/v1/image/running%20sneakers',
                                      title: 'Workout',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.genreTileModel10,
                                    updateCallback: () => safeSetState(() {}),
                                    child: GenreTileWidget(
                                      color: Color(0xFF8400E7),
                                      imgDesc:
                                          'https://dimg.dreamflow.cloud/v1/image/neon%20disco%20ball',
                                      title: 'Party',
                                    ),
                                  ),
                                ],
                              ),
                            ].divide(SizedBox(height: 16.0)),
                          ),
                          Container(
                            height: 80.0,
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
                      height: 72.0,
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
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Container(
                                    width: 56.0,
                                    height: 56.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: CachedNetworkImage(
                                      fadeInDuration: Duration(milliseconds: 0),
                                      fadeOutDuration:
                                          Duration(milliseconds: 0),
                                      imageUrl:
                                          'https://dimg.dreamflow.cloud/v1/image/modern%20synthwave%20album%20art%20neon',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Midnight City',
                                        maxLines: 1,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              font: GoogleFonts.roboto(
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .fontStyle,
                                              lineHeight: 1.5,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'M83 • Hurry Up, We\'re Dreaming',
                                        maxLines: 1,
                                        style: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .override(
                                              font: GoogleFonts.roboto(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontStyle,
                                              lineHeight: 1.5,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ].divide(SizedBox(height: 4.0)),
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
                                        Icons.favorite_border_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 24.0,
                                      ),
                                      onPressed: () {
                                        print('IconButton pressed ...');
                                      },
                                    ),
                                    FlutterFlowIconButton(
                                      borderRadius: 8.0,
                                      buttonSize: 56.0,
                                      fillColor: Colors.transparent,
                                      icon: Icon(
                                        Icons.pause_circle_filled_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 40.0,
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
