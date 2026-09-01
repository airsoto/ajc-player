import '/components/control_button/control_button_widget.dart';
import '/components/slider/slider_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'now_playing_widget.dart' show NowPlayingWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NowPlayingModel extends FlutterFlowModel<NowPlayingWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Slider.
  late SliderModel sliderModel;
  // Model for ControlButton.
  late ControlButtonModel controlButtonModel1;
  // Model for ControlButton.
  late ControlButtonModel controlButtonModel2;
  // Model for ControlButton.
  late ControlButtonModel controlButtonModel3;
  // Model for ControlButton.
  late ControlButtonModel controlButtonModel4;

  @override
  void initState(BuildContext context) {
    sliderModel = createModel(context, () => SliderModel());
    controlButtonModel1 = createModel(context, () => ControlButtonModel());
    controlButtonModel2 = createModel(context, () => ControlButtonModel());
    controlButtonModel3 = createModel(context, () => ControlButtonModel());
    controlButtonModel4 = createModel(context, () => ControlButtonModel());
  }

  @override
  void dispose() {
    sliderModel.dispose();
    controlButtonModel1.dispose();
    controlButtonModel2.dispose();
    controlButtonModel3.dispose();
    controlButtonModel4.dispose();
  }
}
