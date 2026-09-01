import '/components/genre_tile/genre_tile_widget.dart';
import '/components/recent_search/recent_search_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'search_explore_widget.dart' show SearchExploreWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_palette/material_palette.dart';
import 'package:provider/provider.dart';

class SearchExploreModel extends FlutterFlowModel<SearchExploreWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for RecentSearch.
  late RecentSearchModel recentSearchModel1;
  // Model for RecentSearch.
  late RecentSearchModel recentSearchModel2;
  // Model for RecentSearch.
  late RecentSearchModel recentSearchModel3;
  // Model for GenreTile.
  late GenreTileModel genreTileModel1;
  // Model for GenreTile.
  late GenreTileModel genreTileModel2;
  // Model for GenreTile.
  late GenreTileModel genreTileModel3;
  // Model for GenreTile.
  late GenreTileModel genreTileModel4;
  // Model for GenreTile.
  late GenreTileModel genreTileModel5;
  // Model for GenreTile.
  late GenreTileModel genreTileModel6;
  // Model for GenreTile.
  late GenreTileModel genreTileModel7;
  // Model for GenreTile.
  late GenreTileModel genreTileModel8;
  // Model for GenreTile.
  late GenreTileModel genreTileModel9;
  // Model for GenreTile.
  late GenreTileModel genreTileModel10;

  @override
  void initState(BuildContext context) {
    textFieldModel = createModel(context, () => TextFieldModel());
    recentSearchModel1 = createModel(context, () => RecentSearchModel());
    recentSearchModel2 = createModel(context, () => RecentSearchModel());
    recentSearchModel3 = createModel(context, () => RecentSearchModel());
    genreTileModel1 = createModel(context, () => GenreTileModel());
    genreTileModel2 = createModel(context, () => GenreTileModel());
    genreTileModel3 = createModel(context, () => GenreTileModel());
    genreTileModel4 = createModel(context, () => GenreTileModel());
    genreTileModel5 = createModel(context, () => GenreTileModel());
    genreTileModel6 = createModel(context, () => GenreTileModel());
    genreTileModel7 = createModel(context, () => GenreTileModel());
    genreTileModel8 = createModel(context, () => GenreTileModel());
    genreTileModel9 = createModel(context, () => GenreTileModel());
    genreTileModel10 = createModel(context, () => GenreTileModel());
  }

  @override
  void dispose() {
    textFieldModel.dispose();
    recentSearchModel1.dispose();
    recentSearchModel2.dispose();
    recentSearchModel3.dispose();
    genreTileModel1.dispose();
    genreTileModel2.dispose();
    genreTileModel3.dispose();
    genreTileModel4.dispose();
    genreTileModel5.dispose();
    genreTileModel6.dispose();
    genreTileModel7.dispose();
    genreTileModel8.dispose();
    genreTileModel9.dispose();
    genreTileModel10.dispose();
  }
}
