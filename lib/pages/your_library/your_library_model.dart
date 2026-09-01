import '/components/category_chip/category_chip_widget.dart';
import '/components/library_item/library_item_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'your_library_widget.dart' show YourLibraryWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class YourLibraryModel extends FlutterFlowModel<YourLibraryWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for CategoryChip.
  late CategoryChipModel categoryChipModel1;
  // Model for CategoryChip.
  late CategoryChipModel categoryChipModel2;
  // Model for CategoryChip.
  late CategoryChipModel categoryChipModel3;
  // Model for CategoryChip.
  late CategoryChipModel categoryChipModel4;
  // Model for LibraryItem.
  late LibraryItemModel libraryItemModel1;
  // Model for LibraryItem.
  late LibraryItemModel libraryItemModel2;
  // Model for LibraryItem.
  late LibraryItemModel libraryItemModel3;
  // Model for LibraryItem.
  late LibraryItemModel libraryItemModel4;
  // Model for LibraryItem.
  late LibraryItemModel libraryItemModel5;
  // Model for LibraryItem.
  late LibraryItemModel libraryItemModel6;
  // Model for LibraryItem.
  late LibraryItemModel libraryItemModel7;
  // Model for LibraryItem.
  late LibraryItemModel libraryItemModel8;
  // Model for LibraryItem.
  late LibraryItemModel libraryItemModel9;
  // Model for LibraryItem.
  late LibraryItemModel libraryItemModel10;

  @override
  void initState(BuildContext context) {
    categoryChipModel1 = createModel(context, () => CategoryChipModel());
    categoryChipModel2 = createModel(context, () => CategoryChipModel());
    categoryChipModel3 = createModel(context, () => CategoryChipModel());
    categoryChipModel4 = createModel(context, () => CategoryChipModel());
    libraryItemModel1 = createModel(context, () => LibraryItemModel());
    libraryItemModel2 = createModel(context, () => LibraryItemModel());
    libraryItemModel3 = createModel(context, () => LibraryItemModel());
    libraryItemModel4 = createModel(context, () => LibraryItemModel());
    libraryItemModel5 = createModel(context, () => LibraryItemModel());
    libraryItemModel6 = createModel(context, () => LibraryItemModel());
    libraryItemModel7 = createModel(context, () => LibraryItemModel());
    libraryItemModel8 = createModel(context, () => LibraryItemModel());
    libraryItemModel9 = createModel(context, () => LibraryItemModel());
    libraryItemModel10 = createModel(context, () => LibraryItemModel());
  }

  @override
  void dispose() {
    categoryChipModel1.dispose();
    categoryChipModel2.dispose();
    categoryChipModel3.dispose();
    categoryChipModel4.dispose();
    libraryItemModel1.dispose();
    libraryItemModel2.dispose();
    libraryItemModel3.dispose();
    libraryItemModel4.dispose();
    libraryItemModel5.dispose();
    libraryItemModel6.dispose();
    libraryItemModel7.dispose();
    libraryItemModel8.dispose();
    libraryItemModel9.dispose();
    libraryItemModel10.dispose();
  }
}
