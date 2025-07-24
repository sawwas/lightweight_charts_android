import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'chart_api.dart';

class LightweightChartsWidget extends StatefulWidget {
  final Function(ChartApi)? onChartCreated;
  final double? width;
  final double? height;
  
  const LightweightChartsWidget({
    Key? key,
    this.onChartCreated,
    this.width,
    this.height,
  }) : super(key: key);
  
  @override
  State<LightweightChartsWidget> createState() => _LightweightChartsWidgetState();
}

class _LightweightChartsWidgetState extends State<LightweightChartsWidget> {
  ChartApi? _chartApi;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AndroidView(
        viewType: 'lightweight_charts_view',
        onPlatformViewCreated: _onPlatformViewCreated,
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        },
      ),
    );
  }
  
  void _onPlatformViewCreated(int id) async {
    try {
      _chartApi = await ChartApi.create();
      if (widget.onChartCreated != null) {
        widget.onChartCreated!(_chartApi!);
      }
    } catch (e) {
      debugPrint('Error creating chart: $e');
    }
  }
  
  @override
  void dispose() {
    _chartApi?.remove();
    super.dispose();
  }
}
