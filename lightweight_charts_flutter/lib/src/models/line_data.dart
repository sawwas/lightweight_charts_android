import 'time.dart';

class LineData {
  final Time time;
  final double value;
  final int? color;
  
  LineData({
    required this.time,
    required this.value,
    this.color,
  });
  
  Map<String, dynamic> toJson() => {
    'time': time.toJson(),
    'value': value,
    if (color != null) 'color': color,
  };
  
  factory LineData.fromJson(Map<String, dynamic> json) {
    return LineData(
      time: Time.fromJson(json['time']),
      value: json['value'].toDouble(),
      color: json['color'],
    );
  }
}
