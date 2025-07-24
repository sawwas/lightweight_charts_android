import 'dart:async';
import 'package:flutter/services.dart';
import 'models/models.dart';
import 'series_api.dart';

class ChartApi {
  static const MethodChannel _channel = MethodChannel('lightweight_charts_flutter');
  final String _chartId;
  
  ChartApi._(this._chartId);
  
  static Future<ChartApi> create() async {
    final String chartId = await _channel.invokeMethod('createChart');
    return ChartApi._(chartId);
  }
  
  Future<SeriesApi> addHistogramSeries({HistogramSeriesOptions? options}) async {
    final String seriesId = await _channel.invokeMethod('addHistogramSeries', {
      'chartId': _chartId,
      'options': options?.toJson() ?? {},
    });
    return SeriesApi._(seriesId, _chartId);
  }
  
  Future<SeriesApi> addCandlestickSeries({CandlestickSeriesOptions? options}) async {
    final String seriesId = await _channel.invokeMethod('addCandlestickSeries', {
      'chartId': _chartId,
      'options': options?.toJson() ?? {},
    });
    return SeriesApi._(seriesId, _chartId);
  }
  
  Future<SeriesApi> addAreaSeries({AreaSeriesOptions? options}) async {
    final String seriesId = await _channel.invokeMethod('addAreaSeries', {
      'chartId': _chartId,
      'options': options?.toJson() ?? {},
    });
    return SeriesApi._(seriesId, _chartId);
  }
  
  Future<SeriesApi> addLineSeries({LineSeriesOptions? options}) async {
    final String seriesId = await _channel.invokeMethod('addLineSeries', {
      'chartId': _chartId,
      'options': options?.toJson() ?? {},
    });
    return SeriesApi._(seriesId, _chartId);
  }
  
  Future<SeriesApi> addBarSeries({BarSeriesOptions? options}) async {
    final String seriesId = await _channel.invokeMethod('addBarSeries', {
      'chartId': _chartId,
      'options': options?.toJson() ?? {},
    });
    return SeriesApi._(seriesId, _chartId);
  }
  
  Future<void> removeSeries(SeriesApi series) async {
    await _channel.invokeMethod('removeSeries', {
      'chartId': _chartId,
      'seriesId': series._seriesId,
    });
  }
  
  Future<void> applyOptions(ChartOptions options) async {
    await _channel.invokeMethod('applyOptions', {
      'chartId': _chartId,
      'options': options.toJson(),
    });
  }
  
  Future<void> remove() async {
    await _channel.invokeMethod('removeChart', {
      'chartId': _chartId,
    });
  }
  
  void subscribeClick(Function(Map<String, dynamic>) callback) {
    // TODO: Implement event subscription
  }
  
  void subscribeCrosshairMove(Function(Map<String, dynamic>) callback) {
    // TODO: Implement event subscription
  }
}
