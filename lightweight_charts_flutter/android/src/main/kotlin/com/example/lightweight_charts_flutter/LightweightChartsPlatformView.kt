package com.example.lightweight_charts_flutter

import android.content.Context
import android.view.View
import com.tradingview.lightweightcharts.view.ChartsView
import io.flutter.plugin.platform.PlatformView

class LightweightChartsPlatformView(
    context: Context,
    id: Int,
    creationParams: Any?
) : PlatformView {
    
    private val chartsView: ChartsView = ChartsView(context)
    
    init {
        // Store the chart API instance for later use
        LightweightChartsFlutterPlugin.registerChartView(id, chartsView.api)
    }
    
    override fun getView(): View {
        return chartsView
    }
    
    override fun dispose() {
        // Clean up resources if needed
        LightweightChartsFlutterPlugin.unregisterChartView(chartsView.api)
    }
    
    fun getChartsView(): ChartsView {
        return chartsView
    }
}
