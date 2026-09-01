import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'control_button_model.dart';
export 'control_button_model.dart';

class ControlButtonWidget extends StatefulWidget {
  const ControlButtonWidget({
    super.key,
    String? icon,
    double? size,
    bool? active,
  })  : this.icon = icon ?? 'shuffle_rounded',
        this.size = size ?? 24.0,
        this.active = active ?? true;

  final String icon;
  final double size;
  final bool active;

  @override
  State<ControlButtonWidget> createState() => _ControlButtonWidgetState();
}

class _ControlButtonWidgetState extends State<ControlButtonWidget> {
  late ControlButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ControlButtonModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterFlowIconButton(
      borderRadius: 8.0,
      buttonSize: 40.0,
      fillColor: Colors.transparent,
      icon: Icon(
        Icons.shuffle_rounded,
        color: valueOrDefault<Color>(
          valueOrDefault<bool>(
            widget!.active,
            true,
          )
              ? FlutterFlowTheme.of(context).primary
              : FlutterFlowTheme.of(context).primaryText,
          FlutterFlowTheme.of(context).primary,
        ),
        size: 24.0,
      ),
      onPressed: () {
        print('IconButton pressed ...');
      },
    );
  }
}
