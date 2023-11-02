import 'package:flutter/material.dart';
import 'package:coin_watcher/models/history_coin_model.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartView extends StatefulWidget {
  const ChartView({super.key,required this.historyPrices});

  final List<HistoryCoinModel> historyPrices;

  @override
  State<ChartView> createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  late List<String> historyPricesDates;
  late List<double> historyPricesDouble;
  late double minimumYval;
  late double maximumYval;
  late int intervalForChart;


  @override
  void initState() {
    super.initState();

    historyPricesDouble = List<double>.from(widget.historyPrices.map((price) => double.parse(price.price)));
    
    var maximumNumber = historyPricesDouble.reduce((value, element) => value > element ? value : element);
    var minimumNumber = historyPricesDouble.reduce((value, element) => value < element ? value : element);
    minimumYval = minimumNumber;
    maximumYval = maximumNumber;

    var diff = (maximumNumber - minimumNumber).ceilToDouble();
     if (diff<10) {
      intervalForChart = 1;
    } else {
      intervalForChart = (diff ~/ 10);
    }

    historyPricesDates = List<String>.from(widget.historyPrices.map((price) {
      var date = DateTime.fromMillisecondsSinceEpoch(price.time);
      var month = date.month;
      var day = date.day;
      return "$day/$month";
    }));
  }


  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.normal,fontSize: 12);
    Widget text = Text(historyPricesDates[value.toInt()-1], style: style);
    return SideTitleWidget(axisSide: meta.axisSide,child: text);
  }


  Widget leftTitleWidgets(double value, TitleMeta meta) {
    var style = const TextStyle(fontWeight: FontWeight.bold, fontSize: 9);
    String text;
    if (value == minimumYval) {
      text = "\$${minimumYval.toStringAsFixed(1)}";
    } else if(value == maximumYval) {
      text = "\$${maximumYval.toStringAsFixed(1)}";
    } else {
      text = ""; 
    }
    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: intervalForChart.toDouble(),
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(color: Colors.grey, strokeWidth: 0.5);
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(color: Colors.grey,strokeWidth: 0.5);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 25,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50,
            interval: intervalForChart.toDouble(),
            getTitlesWidget: leftTitleWidgets,
          ),
        ),
      ),
      borderData: FlBorderData(show: true,border: Border.all(color: Colors.grey)),
      minX: 1,
      maxX: 5,
      minY: minimumYval,
      maxY: maximumYval,
      lineBarsData: [
        LineChartBarData(
          spots:   
          [
            FlSpot(1, historyPricesDouble[0]),
            FlSpot(2, historyPricesDouble[1]),
            FlSpot(3, historyPricesDouble[2]),
            FlSpot(4, historyPricesDouble[3]),
            FlSpot(5, historyPricesDouble[4]),
          ],
          isCurved: true,
          gradient: LinearGradient(colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColorDark]),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: true),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [Theme.of(context).primaryColorLight, Theme.of(context).primaryColor].map((color) => color.withOpacity(0.2)).toList(),
            ),
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return LineChart(mainData());
  }
}