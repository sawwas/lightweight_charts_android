class ChartOptions {
  final LayoutOptions? layout;
  final GridOptions? grid;
  final CrosshairOptions? crosshair;
  final TimeScaleOptions? timeScale;
  final int? width;
  final int? height;
  
  ChartOptions({
    this.layout,
    this.grid,
    this.crosshair,
    this.timeScale,
    this.width,
    this.height,
  });
  
  Map<String, dynamic> toJson() => {
    if (layout != null) 'layout': layout!.toJson(),
    if (grid != null) 'grid': grid!.toJson(),
    if (crosshair != null) 'crosshair': crosshair!.toJson(),
    if (timeScale != null) 'timeScale': timeScale!.toJson(),
    if (width != null) 'width': width,
    if (height != null) 'height': height,
  };
}

class LayoutOptions {
  final int? backgroundColor;
  final int? textColor;
  final String? fontFamily;
  final int? fontSize;
  
  LayoutOptions({
    this.backgroundColor,
    this.textColor,
    this.fontFamily,
    this.fontSize,
  });
  
  Map<String, dynamic> toJson() => {
    if (backgroundColor != null) 'backgroundColor': backgroundColor,
    if (textColor != null) 'textColor': textColor,
    if (fontFamily != null) 'fontFamily': fontFamily,
    if (fontSize != null) 'fontSize': fontSize,
  };
}

class GridOptions {
  final bool? vertLines;
  final bool? horzLines;
  
  GridOptions({
    this.vertLines,
    this.horzLines,
  });
  
  Map<String, dynamic> toJson() => {
    if (vertLines != null) 'vertLines': vertLines,
    if (horzLines != null) 'horzLines': horzLines,
  };
}

class CrosshairOptions {
  final String? mode;
  
  CrosshairOptions({
    this.mode,
  });
  
  Map<String, dynamic> toJson() => {
    if (mode != null) 'mode': mode,
  };
}

class TimeScaleOptions {
  final bool? rightOffset;
  final bool? barSpacing;
  final bool? fixLeftEdge;
  final bool? fixRightEdge;
  
  TimeScaleOptions({
    this.rightOffset,
    this.barSpacing,
    this.fixLeftEdge,
    this.fixRightEdge,
  });
  
  Map<String, dynamic> toJson() => {
    if (rightOffset != null) 'rightOffset': rightOffset,
    if (barSpacing != null) 'barSpacing': barSpacing,
    if (fixLeftEdge != null) 'fixLeftEdge': fixLeftEdge,
    if (fixRightEdge != null) 'fixRightEdge': fixRightEdge,
  };
}
