import '/components/album_card/album_card_widget.dart';
import '/components/button/button_widget.dart';
import '/components/quick_mix/quick_mix_widget.dart';
import '/components/section_header/section_header_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'home_feed_widget.dart' show HomeFeedWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_palette/material_palette.dart';
import 'package:provider/provider.dart';

class HomeFeedModel extends FlutterFlowModel<HomeFeedWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for QuickMix.
  late QuickMixModel quickMixModel1;
  // Model for QuickMix.
  late QuickMixModel quickMixModel2;
  // Model for QuickMix.
  late QuickMixModel quickMixModel3;
  // Model for SectionHeader.
  late SectionHeaderModel sectionHeaderModel1;
  // Model for AlbumCard.
  late AlbumCardModel albumCardModel1;
  // Model for AlbumCard.
  late AlbumCardModel albumCardModel2;
  // Model for AlbumCard.
  late AlbumCardModel albumCardModel3;
  // Model for SectionHeader.
  late SectionHeaderModel sectionHeaderModel2;
  // Model for Button.
  late ButtonModel buttonModel;
  // Model for SectionHeader.
  late SectionHeaderModel sectionHeaderModel3;

  @override
  void initState(BuildContext context) {
    quickMixModel1 = createModel(context, () => QuickMixModel());
    quickMixModel2 = createModel(context, () => QuickMixModel());
    quickMixModel3 = createModel(context, () => QuickMixModel());
    sectionHeaderModel1 = createModel(context, () => SectionHeaderModel());
    albumCardModel1 = createModel(context, () => AlbumCardModel());
    albumCardModel2 = createModel(context, () => AlbumCardModel());
    albumCardModel3 = createModel(context, () => AlbumCardModel());
    sectionHeaderModel2 = createModel(context, () => SectionHeaderModel());
    buttonModel = createModel(context, () => ButtonModel());
    sectionHeaderModel3 = createModel(context, () => SectionHeaderModel());
  }

  @override
  void dispose() {
    quickMixModel1.dispose();
    quickMixModel2.dispose();
    quickMixModel3.dispose();
    sectionHeaderModel1.dispose();
    albumCardModel1.dispose();
    albumCardModel2.dispose();
    albumCardModel3.dispose();
    sectionHeaderModel2.dispose();
    buttonModel.dispose();
    sectionHeaderModel3.dispose();
  }
}
