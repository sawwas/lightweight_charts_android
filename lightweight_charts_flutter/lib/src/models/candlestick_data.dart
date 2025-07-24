import 'time.dart';

class CandlestickData {
  final Time time;
  final double open;
  final double high;
  final double low;
  final double close;
  final int? color;
  final int? borderColor;
  final int? wickColor;
  
  CandlestickData({
    required this.time,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    this.color,
    this.borderColor,
    this.wickColor,
  });
  
  Map<String, dynamic> toJson() => {
    'time': time.toJson(),
    'open': open,
    'high': high,
    'low': low,
    'close': close,
    if (color != null) 'color': color,
    if (borderColor != null) 'borderColor': borderColor,
    if (wickColor != null) 'wickColor': wickColor,
  };
  
  factory CandlestickData.fromJson(Map<String, dynamic> json) {
    return CandlestickData(
      time: Time.fromJson(json['time']),
      open: json['open'].toDouble(),
      high: json['high'].toDouble(),
      low: json['low'].toDouble(),
      close: json['close'].toDouble(),
      color: json['color'],
      borderColor: json['borderColor'],
      wickColor: json['wickColor'],
    );
  }
}
