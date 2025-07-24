import 'time.dart';

class BarData {
  final Time time;
  final double open;
  final double high;
  final double low;
  final double close;
  
  BarData({
    required this.time,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });
  
  Map<String, dynamic> toJson() => {
    'time': time.toJson(),
    'open': open,
    'high': high,
    'low': low,
    'close': close,
  };
  
  factory BarData.fromJson(Map<String, dynamic> json) {
    return BarData(
      time: Time.fromJson(json['time']),
      open: json['open'].toDouble(),
      high: json['high'].toDouble(),
      low: json['low'].toDouble(),
      close: json['close'].toDouble(),
    );
  }
}
