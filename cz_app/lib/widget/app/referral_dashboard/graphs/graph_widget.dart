import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/graph.dart';
import '../data/graph_data.dart';

class RefferalLineChart extends StatelessWidget {
  final List<Graph>? graph;
  final bool isShowingMainData;

  const RefferalLineChart({
    super.key,
    required this.isShowingMainData,
    required this.graph,
  });

  get getSpotsOpens => getSpotsOpen();

  get getSpotsCloseds => getSpotsClosed();

  get value => graph
      ?.reduce((prev, current) =>
          prev.AmmountOfNewReferrals > current.AmmountOfNewReferrals
              ? prev
              : current)
      .AmmountOfNewReferrals;

  List<FlSpot> getSpotsOpen() {
    List<FlSpot> spotlist = [];
    for (var obj in graph!) {
      double x = obj.Month;
      double y = obj.AmmountOfNewReferrals;
      spotlist.add(FlSpot(x, y));
    }
    return spotlist;
  }

  List<FlSpot> getSpotsClosed() {
    List<FlSpot> spotlist = [];
    for (var obj in graph!) {
      double x = obj.Month;
      double y = obj.AmmountOfApprovedReferrals;
      spotlist.add(FlSpot(x, y));
    }
    return spotlist;
  }

  @override
  Widget build(BuildContext context) {
    createLines();
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
        maxY: value,
        minY: 0,
      );

  //empty so that if backup is fetched, it will be empty
  LineChartData get BackupData => LineChartData();

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white12,
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
    final text = ((value).toString());
    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: (value < 20) ? 1.0 : (value / 20).floor().toDouble(),
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
        text = const Text('jan', style: style);
        break;
      case 2:
        text = const Text('feb', style: style);
        break;
      case 3:
        text = const Text('mar', style: style);
        break;
      case 4:
        text = const Text('apr', style: style);
        break;
      case 5:
        text = const Text('mei', style: style);
        break;
      case 6:
        text = const Text('jun', style: style);
        break;
      case 7:
        text = const Text('jul', style: style);
        break;
      case 8:
        text = const Text('aug', style: style);
        break;
      case 9:
        text = const Text('sep', style: style);
        break;
      case 10:
        text = const Text('oct', style: style);
        break;
      case 11:
        text = const Text('nov', style: style);
        break;
      case 12:
        text = const Text('dec', style: style);
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
        spots: getSpotsOpens,
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
        spots: getSpotsClosed(),
      );

  void createLines() {}
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
                'Aandrachten',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: double.maxFinite,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Row(
                          children: [
                            Container(
                              color: Colors.teal,
                              width: 10.0,
                              height: 10.0,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Text('Totaal aantal aandrachten'),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Row(
                          children: [
                            Container(
                              color: Colors.orange,
                              width: 10.0,
                              height: 10.0,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Text('Aantal succesvolle aandrachten'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 37,
              ),
              FutureBuilder<List<Graph>>(
                future: fetchGraphData(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Graph>> snapshot) {
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
                    debugPrint("${snapshot.error}");
                    return const Text(
                        "there has been a error while loading the data");
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
