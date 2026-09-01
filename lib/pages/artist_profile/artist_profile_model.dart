import '/components/album_card94680390/album_card94680390_widget.dart';
import '/components/button/button_widget.dart';
import '/components/track_item880892d8/track_item880892d8_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'artist_profile_widget.dart' show ArtistProfileWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ArtistProfileModel extends FlutterFlowModel<ArtistProfileWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for Button.
  late ButtonModel buttonModel2;
  // Model for TrackItem880892d8.
  late TrackItem880892d8Model trackItem880892d8Model1;
  // Model for TrackItem880892d8.
  late TrackItem880892d8Model trackItem880892d8Model2;
  // Model for TrackItem880892d8.
  late TrackItem880892d8Model trackItem880892d8Model3;
  // Model for TrackItem880892d8.
  late TrackItem880892d8Model trackItem880892d8Model4;
  // Model for TrackItem880892d8.
  late TrackItem880892d8Model trackItem880892d8Model5;
  // Model for Button.
  late ButtonModel buttonModel3;
  // Model for AlbumCard94680390.
  late AlbumCard94680390Model albumCard94680390Model1;
  // Model for AlbumCard94680390.
  late AlbumCard94680390Model albumCard94680390Model2;
  // Model for AlbumCard94680390.
  late AlbumCard94680390Model albumCard94680390Model3;

  @override
  void initState(BuildContext context) {
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
    trackItem880892d8Model1 =
        createModel(context, () => TrackItem880892d8Model());
    trackItem880892d8Model2 =
        createModel(context, () => TrackItem880892d8Model());
    trackItem880892d8Model3 =
        createModel(context, () => TrackItem880892d8Model());
    trackItem880892d8Model4 =
        createModel(context, () => TrackItem880892d8Model());
    trackItem880892d8Model5 =
        createModel(context, () => TrackItem880892d8Model());
    buttonModel3 = createModel(context, () => ButtonModel());
    albumCard94680390Model1 =
        createModel(context, () => AlbumCard94680390Model());
    albumCard94680390Model2 =
        createModel(context, () => AlbumCard94680390Model());
    albumCard94680390Model3 =
        createModel(context, () => AlbumCard94680390Model());
  }

  @override
  void dispose() {
    buttonModel1.dispose();
    buttonModel2.dispose();
    trackItem880892d8Model1.dispose();
    trackItem880892d8Model2.dispose();
    trackItem880892d8Model3.dispose();
    trackItem880892d8Model4.dispose();
    trackItem880892d8Model5.dispose();
    buttonModel3.dispose();
    albumCard94680390Model1.dispose();
    albumCard94680390Model2.dispose();
    albumCard94680390Model3.dispose();
  }
}
