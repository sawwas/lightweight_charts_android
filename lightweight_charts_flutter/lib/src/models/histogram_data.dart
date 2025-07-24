import 'time.dart';

class HistogramData {
  final Time time;
  final double value;
  final int? color;
  
  HistogramData({
    required this.time,
    required this.value,
    this.color,
  });
  
  Map<String, dynamic> toJson() => {
    'time': time.toJson(),
    'value': value,
    if (color != null) 'color': color,
  };
  
  factory HistogramData.fromJson(Map<String, dynamic> json) {
    return HistogramData(
      time: Time.fromJson(json['time']),
      value: json['value'].toDouble(),
      color: json['color'],
    );
  }
}
