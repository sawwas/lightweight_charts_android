import 'package:flutter/material.dart';
import 'package:lightweight_charts_flutter/lightweight_charts_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lightweight Charts Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChartDemoPage(),
    );
  }
}

class ChartDemoPage extends StatefulWidget {
  const ChartDemoPage({super.key});

  @override
  State<ChartDemoPage> createState() => _ChartDemoPageState();
}

class _ChartDemoPageState extends State<ChartDemoPage> {
  ChartApi? _chartApi;
  SeriesApi? _candlestickSeries;
  SeriesApi? _histogramSeries;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lightweight Charts Flutter'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: LightweightChartsWidget(
                onChartCreated: _onChartCreated,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Chart Controls',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _addCandlestickSeries,
                        child: const Text('Add Candlestick'),
                      ),
                      ElevatedButton(
                        onPressed: _addHistogramSeries,
                        child: const Text('Add Histogram'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _updateData,
                        child: const Text('Update Data'),
                      ),
                      ElevatedButton(
                        onPressed: _clearChart,
                        child: const Text('Clear Chart'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onChartCreated(ChartApi chartApi) {
    setState(() {
      _chartApi = chartApi;
    });
    
    // Apply some basic chart options
    _chartApi?.applyOptions(ChartOptions(
      layout: LayoutOptions(
        backgroundColor: 0xFFFFFFFF,
        textColor: 0xFF000000,
      ),
      grid: GridOptions(
        vertLines: true,
        horzLines: true,
      ),
    ));
  }

  void _addCandlestickSeries() async {
    if (_chartApi == null) return;
    
    try {
      final series = await _chartApi!.addCandlestickSeries(
        options: CandlestickSeriesOptions(
          upColor: 0xFF26A69A,
          downColor: 0xFFEF5350,
          borderUpColor: 0xFF26A69A,
          borderDownColor: 0xFFEF5350,
          wickUpColor: 0xFF26A69A,
          wickDownColor: 0xFFEF5350,
          title: 'AAPL',
        ),
      );
      
      setState(() {
        _candlestickSeries = series;
      });
      
      // Add sample candlestick data
      final sampleData = [
        CandlestickData(
          time: Utc.fromDate(DateTime(2023, 1, 1)),
          open: 150.0,
          high: 155.0,
          low: 148.0,
          close: 152.0,
        ),
        CandlestickData(
          time: Utc.fromDate(DateTime(2023, 1, 2)),
          open: 152.0,
          high: 158.0,
          low: 151.0,
          close: 157.0,
        ),
        CandlestickData(
          time: Utc.fromDate(DateTime(2023, 1, 3)),
          open: 157.0,
          high: 159.0,
          low: 154.0,
          close: 155.0,
        ),
        CandlestickData(
          time: Utc.fromDate(DateTime(2023, 1, 4)),
          open: 155.0,
          high: 161.0,
          low: 153.0,
          close: 160.0,
        ),
        CandlestickData(
          time: Utc.fromDate(DateTime(2023, 1, 5)),
          open: 160.0,
          high: 162.0,
          low: 157.0,
          close: 158.0,
        ),
      ];
      
      await series.setData(sampleData);
    } catch (e) {
      debugPrint('Error adding candlestick series: $e');
    }
  }

  void _addHistogramSeries() async {
    if (_chartApi == null) return;
    
    try {
      final series = await _chartApi!.addHistogramSeries(
        options: HistogramSeriesOptions(
          color: 0xFF2196F3,
          title: 'Volume',
        ),
      );
      
      setState(() {
        _histogramSeries = series;
      });
      
      // Add sample histogram data
      final sampleData = [
        HistogramData(
          time: Utc.fromDate(DateTime(2023, 1, 1)),
          value: 1000000.0,
        ),
        HistogramData(
          time: Utc.fromDate(DateTime(2023, 1, 2)),
          value: 1200000.0,
        ),
        HistogramData(
          time: Utc.fromDate(DateTime(2023, 1, 3)),
          value: 800000.0,
        ),
        HistogramData(
          time: Utc.fromDate(DateTime(2023, 1, 4)),
          value: 1500000.0,
        ),
        HistogramData(
          time: Utc.fromDate(DateTime(2023, 1, 5)),
          value: 900000.0,
        ),
      ];
      
      await series.setData(sampleData);
    } catch (e) {
      debugPrint('Error adding histogram series: $e');
    }
  }

  void _updateData() async {
    if (_candlestickSeries == null) return;
    
    try {
      // Update with new data point
      await _candlestickSeries!.update(
        CandlestickData(
          time: Utc.fromDate(DateTime(2023, 1, 6)),
          open: 158.0,
          high: 165.0,
          low: 156.0,
          close: 163.0,
        ),
      );
      
      if (_histogramSeries != null) {
        await _histogramSeries!.update(
          HistogramData(
            time: Utc.fromDate(DateTime(2023, 1, 6)),
            value: 1100000.0,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error updating data: $e');
    }
  }

  void _clearChart() async {
    if (_chartApi == null) return;
    
    try {
      if (_candlestickSeries != null) {
        await _chartApi!.removeSeries(_candlestickSeries!);
        setState(() {
          _candlestickSeries = null;
        });
      }
      
      if (_histogramSeries != null) {
        await _chartApi!.removeSeries(_histogramSeries!);
        setState(() {
          _histogramSeries = null;
        });
      }
    } catch (e) {
      debugPrint('Error clearing chart: $e');
    }
  }
}
