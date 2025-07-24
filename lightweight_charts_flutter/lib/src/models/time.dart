import 'dart:convert';

abstract class Time {
  Map<String, dynamic> toJson();
  
  factory Time.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('year') && json.containsKey('month') && json.containsKey('day')) {
      return BusinessDay(
        year: json['year'],
        month: json['month'],
        day: json['day'],
      );
    } else if (json.containsKey('timestamp')) {
      return Utc(timestamp: json['timestamp']);
    } else if (json.containsKey('source')) {
      return StringTime(source: json['source']);
    } else {
      throw ArgumentError('Invalid Time JSON format');
    }
  }
}

class Utc extends Time {
  final int timestamp;
  
  Utc({required this.timestamp});
  
  factory Utc.fromDate(DateTime date) {
    return Utc(timestamp: date.millisecondsSinceEpoch ~/ 1000);
  }
  
  DateTime get date => DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  
  @override
  Map<String, dynamic> toJson() => {'timestamp': timestamp};
}

class BusinessDay extends Time {
  final int year;
  final int month;
  final int day;
  
  BusinessDay({required this.year, required this.month, required this.day});
  
  DateTime get date => DateTime(year, month, day);
  
  @override
  Map<String, dynamic> toJson() => {
    'year': year,
    'month': month,
    'day': day,
  };
}

class StringTime extends Time {
  final String source;
  
  StringTime({required this.source});
  
  DateTime get date => DateTime.parse(source);
  
  @override
  Map<String, dynamic> toJson() => {'source': source};
}
