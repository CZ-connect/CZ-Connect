import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../models/graph.dart';
import '../data/graph_data.dart';

class RefferalLineChart extends StatelessWidget {
  const RefferalLineChart({
    super.key,
    required this.isShowingMainData,
    required List<Graph>? graph,
  });

  final bool isShowingMainData;

  //TODO uncomment this when the graph model is done
  // final Graph graph;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      isShowingMainData ? StandardData : BackupData,
    );
  }

  LineChartData get StandardData => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 14,
        maxY: 10,
        minY: 0,
      );

  //empty so that if backup is fetched, it will be empty
  LineChartData get BackupData => LineChartData();

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.red,
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarDataOpenReferals,
        lineChartBarDataClosedReferals,
      ];

  LineTouchData get lineTouchData2 => LineTouchData(
        enabled: false,
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  //empty data for the backup
  List<LineChartBarData> get lineBarsData2 => [
        lineChartBarDataOpenReferals,
        lineChartBarDataClosedReferals,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    //make a factory for this based on the data max y value
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10';
        break;
      case 2:
        text = '20';
        break;
      case 3:
        text = '30';
        break;
      case 4:
        text = '40';
        break;
      case 5:
        text = '50';
        break;
      case 6:
        text = '60';
        break;
      case 7:
        text = '70';
        break;
      case 8:
        text = '80';
        break;
      case 9:
        text = '90';
        break;
      case 10:
        text = '100';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    //make a factory for this based on the data max x value
    switch (value.toInt()) {
      case 1:
        text = const Text('January', style: style);
        break;
      case 2:
        text = const Text('February', style: style);
        break;
      case 3:
        text = const Text('March', style: style);
        break;
      case 4:
        text = const Text('April', style: style);
        break;
      case 5:
        text = const Text('May', style: style);
        break;
      case 6:
        text = const Text('June', style: style);
        break;
      case 7:
        text = const Text('July', style: style);
        break;
      case 8:
        text = const Text('August', style: style);
        break;
      case 9:
        text = const Text('September', style: style);
        break;
      case 10:
        text = const Text('October', style: style);
        break;
      case 11:
        text = const Text('November', style: style);
        break;
      case 12:
        text = const Text('December', style: style);
        break;
      default:
        text = const Text('');
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(show: true);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.black12, width: 4),
          left: BorderSide(color: Colors.white12),
          right: BorderSide(color: Colors.white12),
          top: BorderSide(color: Colors.white12),
        ),
      );

  LineChartBarData get lineChartBarDataOpenReferals => LineChartBarData(
        isCurved: true,
        color: Colors.teal,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 0),
          FlSpot(3, 4),
          FlSpot(5, 6),
          FlSpot(7, 7),
          FlSpot(10, 8),
          FlSpot(12, 10),
          FlSpot(12, 0),
        ],
      );

  // bar beween 1 and 2
  LineChartBarData get lineChartBarDataClosedReferals => LineChartBarData(
        isCurved: true,
        color: Colors.orange,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(
          show: false,
          color: Colors.teal,
        ),
        spots: const [
          FlSpot(1, 0),
          FlSpot(3, 2),
          FlSpot(7, 3),
          FlSpot(10, 4),
          FlSpot(12, 8),
          FlSpot(13, 9),
        ],
      );
}

class LineChartSample extends StatefulWidget {
  const LineChartSample({super.key});

  @override
  State<StatefulWidget> createState() => LineReferalState();
}

class LineReferalState extends State<LineChartSample> {
  late bool isShowingMainData = true;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 37,
              ),
              const Text(
                'Referals',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 37,
              ),
              FutureBuilder<List<Graph>>(
                future: GraphData().fetchGraph(),
                builder: (BuildContext context, AsyncSnapshot<List<Graph>> snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 9, left: 6),
                        child: RefferalLineChart(
                          isShowingMainData: isShowingMainData,
                          graph: snapshot.data,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
