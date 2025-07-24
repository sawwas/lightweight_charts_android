import 'time.dart';

class AreaData {
  final Time time;
  final double value;
  
  AreaData({
    required this.time,
    required this.value,
  });
  
  Map<String, dynamic> toJson() => {
    'time': time.toJson(),
    'value': value,
  };
  
  factory AreaData.fromJson(Map<String, dynamic> json) {
    return AreaData(
      time: Time.fromJson(json['time']),
      value: json['value'].toDouble(),
    );
  }
}
