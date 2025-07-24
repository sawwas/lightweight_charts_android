package com.example.lightweight_charts_flutter

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import com.tradingview.lightweightcharts.view.ChartsView
import com.tradingview.lightweightcharts.api.interfaces.ChartApi
import com.tradingview.lightweightcharts.api.interfaces.SeriesApi
import com.tradingview.lightweightcharts.api.options.models.*
import com.tradingview.lightweightcharts.api.series.models.*
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import java.util.UUID

/** LightweightChartsFlutterPlugin */
class LightweightChartsFlutterPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel
  private val seriesInstances = mutableMapOf<String, SeriesApi>()
  private val gson = Gson()
  
  companion object {
    private val chartInstances = mutableMapOf<String, ChartApi>()
    private var currentChartApi: ChartApi? = null
    
    fun registerChartView(viewId: Int, chartApi: ChartApi) {
      currentChartApi = chartApi
    }
    
    fun unregisterChartView(chartApi: ChartApi) {
      if (currentChartApi == chartApi) {
        currentChartApi = null
      }
    }
    
    fun getCurrentChartApi(): ChartApi? = currentChartApi
  }

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "lightweight_charts_flutter")
    channel.setMethodCallHandler(this)
    
    // Register the platform view factory
    flutterPluginBinding
      .platformViewRegistry
      .registerViewFactory("lightweight_charts_view", LightweightChartsViewFactory())
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      "createChart" -> {
        val chartId = UUID.randomUUID().toString()
        val chartApi = getCurrentChartApi()
        if (chartApi != null) {
          chartInstances[chartId] = chartApi
          result.success(chartId)
        } else {
          result.error("NO_CHART", "No chart view available", null)
        }
      }
      "addHistogramSeries" -> {
        addSeries(call, result) { chartApi, options ->
          chartApi.addHistogramSeries(
            options = gson.fromJson(gson.toJson(options), HistogramSeriesOptions::class.java)
          ) { series ->
            val seriesId = UUID.randomUUID().toString()
            seriesInstances[seriesId] = series
            result.success(seriesId)
          }
        }
      }
      "addCandlestickSeries" -> {
        addSeries(call, result) { chartApi, options ->
          chartApi.addCandlestickSeries(
            options = gson.fromJson(gson.toJson(options), CandlestickSeriesOptions::class.java)
          ) { series ->
            val seriesId = UUID.randomUUID().toString()
            seriesInstances[seriesId] = series
            result.success(seriesId)
          }
        }
      }
      "addAreaSeries" -> {
        addSeries(call, result) { chartApi, options ->
          chartApi.addAreaSeries(
            options = gson.fromJson(gson.toJson(options), AreaSeriesOptions::class.java)
          ) { series ->
            val seriesId = UUID.randomUUID().toString()
            seriesInstances[seriesId] = series
            result.success(seriesId)
          }
        }
      }
      "addLineSeries" -> {
        addSeries(call, result) { chartApi, options ->
          chartApi.addLineSeries(
            options = gson.fromJson(gson.toJson(options), LineSeriesOptions::class.java)
          ) { series ->
            val seriesId = UUID.randomUUID().toString()
            seriesInstances[seriesId] = series
            result.success(seriesId)
          }
        }
      }
      "addBarSeries" -> {
        addSeries(call, result) { chartApi, options ->
          chartApi.addBarSeries(
            options = gson.fromJson(gson.toJson(options), BarSeriesOptions::class.java)
          ) { series ->
            val seriesId = UUID.randomUUID().toString()
            seriesInstances[seriesId] = series
            result.success(seriesId)
          }
        }
      }
      "setData" -> {
        val chartId = call.argument<String>("chartId")
        val seriesId = call.argument<String>("seriesId")
        val data = call.argument<List<Map<String, Any>>>("data")
        
        val series = seriesInstances[seriesId]
        if (series != null && data != null) {
          val seriesData = convertToSeriesData(data)
          series.setData(seriesData)
          result.success(null)
        } else {
          result.error("INVALID_SERIES", "Series not found", null)
        }
      }
      "update" -> {
        val chartId = call.argument<String>("chartId")
        val seriesId = call.argument<String>("seriesId")
        val data = call.argument<Map<String, Any>>("data")
        
        val series = seriesInstances[seriesId]
        if (series != null && data != null) {
          val seriesData = convertToSeriesDataItem(data)
          series.update(seriesData)
          result.success(null)
        } else {
          result.error("INVALID_SERIES", "Series not found", null)
        }
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  private fun addSeries(call: MethodCall, result: Result, seriesCreator: (ChartApi, Map<String, Any>) -> Unit) {
    val chartId = call.argument<String>("chartId")
    val options = call.argument<Map<String, Any>>("options") ?: emptyMap()
    
    val chartApi = chartInstances[chartId]
    if (chartApi != null) {
      seriesCreator(chartApi, options)
    } else {
      result.error("INVALID_CHART", "Chart not found", null)
    }
  }

  private fun convertToSeriesData(data: List<Map<String, Any>>): List<com.tradingview.lightweightcharts.api.series.common.SeriesData> {
    return data.map { convertToSeriesDataItem(it) }
  }

  private fun convertToSeriesDataItem(data: Map<String, Any>): com.tradingview.lightweightcharts.api.series.common.SeriesData {
    val timeData = data["time"] as Map<String, Any>
    val time = convertToTime(timeData)
    
    return when {
      data.containsKey("open") && data.containsKey("high") && data.containsKey("low") && data.containsKey("close") -> {
        if (data.containsKey("color") || data.containsKey("borderColor") || data.containsKey("wickColor")) {
          CandlestickData(
            time = time,
            open = (data["open"] as Number).toFloat(),
            high = (data["high"] as Number).toFloat(),
            low = (data["low"] as Number).toFloat(),
            close = (data["close"] as Number).toFloat(),
            color = data["color"] as? com.tradingview.lightweightcharts.api.chart.models.color.IntColor,
            borderColor = data["borderColor"] as? com.tradingview.lightweightcharts.api.chart.models.color.IntColor,
            wickColor = data["wickColor"] as? com.tradingview.lightweightcharts.api.chart.models.color.IntColor
          )
        } else {
          BarData(
            time = time,
            open = (data["open"] as Number).toFloat(),
            high = (data["high"] as Number).toFloat(),
            low = (data["low"] as Number).toFloat(),
            close = (data["close"] as Number).toFloat()
          )
        }
      }
      data.containsKey("value") -> {
        if (data.containsKey("color")) {
          HistogramData(
            time = time,
            value = (data["value"] as Number).toFloat(),
            color = data["color"] as? com.tradingview.lightweightcharts.api.chart.models.color.IntColor
          )
        } else {
          LineData(
            time = time,
            value = (data["value"] as Number).toFloat()
          )
        }
      }
      else -> throw IllegalArgumentException("Invalid series data format")
    }
  }

  private fun convertToTime(timeData: Map<String, Any>): Time {
    return when {
      timeData.containsKey("timestamp") -> {
        Time.Utc(timeData["timestamp"] as Long)
      }
      timeData.containsKey("year") && timeData.containsKey("month") && timeData.containsKey("day") -> {
        Time.BusinessDay(
          timeData["year"] as Int,
          timeData["month"] as Int,
          timeData["day"] as Int
        )
      }
      timeData.containsKey("source") -> {
        Time.StringTime(timeData["source"] as String)
      }
      else -> throw IllegalArgumentException("Invalid time format")
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    chartInstances.clear()
    seriesInstances.clear()
  }
}
