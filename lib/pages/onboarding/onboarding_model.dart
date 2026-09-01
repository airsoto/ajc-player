import '/components/button/button_widget.dart';
import '/components/social_button/social_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'onboarding_widget.dart' show OnboardingWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_palette/material_palette.dart';
import 'package:provider/provider.dart';

class OnboardingModel extends FlutterFlowModel<OnboardingWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for SocialButton.
  late SocialButtonModel socialButtonModel1;
  // Model for SocialButton.
  late SocialButtonModel socialButtonModel2;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    buttonModel1 = createModel(context, () => ButtonModel());
    socialButtonModel1 = createModel(context, () => SocialButtonModel());
    socialButtonModel2 = createModel(context, () => SocialButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    buttonModel1.dispose();
    socialButtonModel1.dispose();
    socialButtonModel2.dispose();
    buttonModel2.dispose();
  }
}
