abstract class SeriesOptions {
  Map<String, dynamic> toJson();
}

class HistogramSeriesOptions extends SeriesOptions {
  final int? color;
  final double? priceLineWidth;
  final bool? priceLineVisible;
  final String? title;
  
  HistogramSeriesOptions({
    this.color,
    this.priceLineWidth,
    this.priceLineVisible,
    this.title,
  });
  
  @override
  Map<String, dynamic> toJson() => {
    if (color != null) 'color': color,
    if (priceLineWidth != null) 'priceLineWidth': priceLineWidth,
    if (priceLineVisible != null) 'priceLineVisible': priceLineVisible,
    if (title != null) 'title': title,
  };
}

class CandlestickSeriesOptions extends SeriesOptions {
  final int? upColor;
  final int? downColor;
  final int? borderUpColor;
  final int? borderDownColor;
  final int? wickUpColor;
  final int? wickDownColor;
  final String? title;
  
  CandlestickSeriesOptions({
    this.upColor,
    this.downColor,
    this.borderUpColor,
    this.borderDownColor,
    this.wickUpColor,
    this.wickDownColor,
    this.title,
  });
  
  @override
  Map<String, dynamic> toJson() => {
    if (upColor != null) 'upColor': upColor,
    if (downColor != null) 'downColor': downColor,
    if (borderUpColor != null) 'borderUpColor': borderUpColor,
    if (borderDownColor != null) 'borderDownColor': borderDownColor,
    if (wickUpColor != null) 'wickUpColor': wickUpColor,
    if (wickDownColor != null) 'wickDownColor': wickDownColor,
    if (title != null) 'title': title,
  };
}

class AreaSeriesOptions extends SeriesOptions {
  final int? topColor;
  final int? bottomColor;
  final int? lineColor;
  final double? lineWidth;
  final String? title;
  
  AreaSeriesOptions({
    this.topColor,
    this.bottomColor,
    this.lineColor,
    this.lineWidth,
    this.title,
  });
  
  @override
  Map<String, dynamic> toJson() => {
    if (topColor != null) 'topColor': topColor,
    if (bottomColor != null) 'bottomColor': bottomColor,
    if (lineColor != null) 'lineColor': lineColor,
    if (lineWidth != null) 'lineWidth': lineWidth,
    if (title != null) 'title': title,
  };
}

class LineSeriesOptions extends SeriesOptions {
  final int? color;
  final double? lineWidth;
  final String? title;
  
  LineSeriesOptions({
    this.color,
    this.lineWidth,
    this.title,
  });
  
  @override
  Map<String, dynamic> toJson() => {
    if (color != null) 'color': color,
    if (lineWidth != null) 'lineWidth': lineWidth,
    if (title != null) 'title': title,
  };
}

class BarSeriesOptions extends SeriesOptions {
  final int? upColor;
  final int? downColor;
  final String? title;
  
  BarSeriesOptions({
    this.upColor,
    this.downColor,
    this.title,
  });
  
  @override
  Map<String, dynamic> toJson() => {
    if (upColor != null) 'upColor': upColor,
    if (downColor != null) 'downColor': downColor,
    if (title != null) 'title': title,
  };
}
