import '/components/track_item/track_item_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'playlist_detail_widget.dart' show PlaylistDetailWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_palette/material_palette.dart';
import 'package:provider/provider.dart';

class PlaylistDetailModel extends FlutterFlowModel<PlaylistDetailWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TrackItem.
  late TrackItemModel trackItemModel1;
  // Model for TrackItem.
  late TrackItemModel trackItemModel2;
  // Model for TrackItem.
  late TrackItemModel trackItemModel3;
  // Model for TrackItem.
  late TrackItemModel trackItemModel4;
  // Model for TrackItem.
  late TrackItemModel trackItemModel5;
  // Model for TrackItem.
  late TrackItemModel trackItemModel6;
  // Model for TrackItem.
  late TrackItemModel trackItemModel7;
  // Model for TrackItem.
  late TrackItemModel trackItemModel8;
  // Model for TrackItem.
  late TrackItemModel trackItemModel9;
  // Model for TrackItem.
  late TrackItemModel trackItemModel10;

  @override
  void initState(BuildContext context) {
    trackItemModel1 = createModel(context, () => TrackItemModel());
    trackItemModel2 = createModel(context, () => TrackItemModel());
    trackItemModel3 = createModel(context, () => TrackItemModel());
    trackItemModel4 = createModel(context, () => TrackItemModel());
    trackItemModel5 = createModel(context, () => TrackItemModel());
    trackItemModel6 = createModel(context, () => TrackItemModel());
    trackItemModel7 = createModel(context, () => TrackItemModel());
    trackItemModel8 = createModel(context, () => TrackItemModel());
    trackItemModel9 = createModel(context, () => TrackItemModel());
    trackItemModel10 = createModel(context, () => TrackItemModel());
  }

  @override
  void dispose() {
    trackItemModel1.dispose();
    trackItemModel2.dispose();
    trackItemModel3.dispose();
    trackItemModel4.dispose();
    trackItemModel5.dispose();
    trackItemModel6.dispose();
    trackItemModel7.dispose();
    trackItemModel8.dispose();
    trackItemModel9.dispose();
    trackItemModel10.dispose();
  }
}
