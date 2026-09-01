import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'storage_info_model.dart';
export 'storage_info_model.dart';

class StorageInfoWidget extends StatefulWidget {
  const StorageInfoWidget({
    super.key,
    String? label,
    Color? tone,
    String? value,
  })  : this.label = label ?? 'SonicStream',
        this.tone = tone ?? const Color(0x00000000),
        this.value = value ?? '12.4 GB';

  final String label;
  final Color tone;
  final String value;

  @override
  State<StorageInfoWidget> createState() => _StorageInfoWidgetState();
}

class _StorageInfoWidgetState extends State<StorageInfoWidget> {
  late StorageInfoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StorageInfoModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: valueOrDefault<Color>(
              widget!.tone,
              FlutterFlowTheme.of(context).primary,
            ),
            borderRadius: BorderRadius.circular(9999.0),
            shape: BoxShape.rectangle,
          ),
        ),
        Text(
          valueOrDefault<String>(
            '${widget!.label}: ${widget!.value}',
            'SonicStream: 12.4 GB',
          ),
          style: FlutterFlowTheme.of(context).labelSmall.override(
                font: GoogleFonts.roboto(
                  fontWeight:
                      FlutterFlowTheme.of(context).labelSmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).secondaryText,
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                lineHeight: 1.3,
              ),
        ),
      ].divide(SizedBox(width: 4.0)),
    );
  }
}
