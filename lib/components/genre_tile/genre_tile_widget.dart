import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'genre_tile_model.dart';
export 'genre_tile_model.dart';

class GenreTileWidget extends StatefulWidget {
  const GenreTileWidget({
    super.key,
    Color? color,
    String? imgDesc,
    String? title,
  })  : this.color = color ?? const Color(0xFFE13300),
        this.imgDesc = imgDesc ??
            'https://dimg.dreamflow.cloud/v1/image/microphone%20studio',
        this.title = title ?? 'Podcasts';

  final Color color;
  final String imgDesc;
  final String title;

  @override
  State<GenreTileWidget> createState() => _GenreTileWidgetState();
}

class _GenreTileWidgetState extends State<GenreTileWidget> {
  late GenreTileModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GenreTileModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        height: 100.0,
        decoration: BoxDecoration(
          color: valueOrDefault<Color>(
            widget!.color,
            Color(0xFFE13300),
          ),
          borderRadius: BorderRadius.circular(12.0),
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Container(
            child: Stack(
              alignment: AlignmentDirectional(-1.0, -1.0),
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      valueOrDefault<String>(
                        widget!.title,
                        'Podcasts',
                      ),
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontStyle,
                            lineHeight: 1.45,
                          ),
                    ),
                  ].divide(SizedBox(height: 4.0)),
                ),
                Align(
                  alignment: AlignmentDirectional(1.0, 1.0),
                  child: Container(
                    alignment: AlignmentDirectional(1.0, 1.0),
                    child: Transform.rotate(
                      angle: 25.0 * (math.pi / 180),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            width: 60.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color:
                                    FlutterFlowTheme.of(context).onSecondary13,
                                width: 2.0,
                              ),
                            ),
                            child: CachedNetworkImage(
                              fadeInDuration: Duration(milliseconds: 0),
                              fadeOutDuration: Duration(milliseconds: 0),
                              imageUrl: valueOrDefault<String>(
                                widget!.imgDesc,
                                'https://dimg.dreamflow.cloud/v1/image/microphone%20studio',
                              ),
                              fit: BoxFit.cover,
                              alignment: Alignment(0.0, 0.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
