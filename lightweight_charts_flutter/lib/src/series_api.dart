import 'dart:async';
import 'package:flutter/services.dart';
import 'models/models.dart';

class SeriesApi {
  static const MethodChannel _channel = MethodChannel('lightweight_charts_flutter');
  final String _seriesId;
  final String _chartId;
  
  SeriesApi._(this._seriesId, this._chartId);
  
  Future<void> setData(List<dynamic> data) async {
    final List<Map<String, dynamic>> serializedData = data.map((item) {
      if (item is HistogramData) return item.toJson();
      if (item is CandlestickData) return item.toJson();
      if (item is AreaData) return item.toJson();
      if (item is LineData) return item.toJson();
      if (item is BarData) return item.toJson();
      throw ArgumentError('Unsupported data type: ${item.runtimeType}');
    }).toList();
    
    await _channel.invokeMethod('setData', {
      'chartId': _chartId,
      'seriesId': _seriesId,
      'data': serializedData,
    });
  }
  
  Future<void> update(dynamic data) async {
    Map<String, dynamic> serializedData;
    if (data is HistogramData) {
      serializedData = data.toJson();
    } else if (data is CandlestickData) {
      serializedData = data.toJson();
    } else if (data is AreaData) {
      serializedData = data.toJson();
    } else if (data is LineData) {
      serializedData = data.toJson();
    } else if (data is BarData) {
      serializedData = data.toJson();
    } else {
      throw ArgumentError('Unsupported data type: ${data.runtimeType}');
    }
    
    await _channel.invokeMethod('update', {
      'chartId': _chartId,
      'seriesId': _seriesId,
      'data': serializedData,
    });
  }
  
  Future<void> applyOptions(SeriesOptions options) async {
    await _channel.invokeMethod('applySeriesOptions', {
      'chartId': _chartId,
      'seriesId': _seriesId,
      'options': options.toJson(),
    });
  }
}
