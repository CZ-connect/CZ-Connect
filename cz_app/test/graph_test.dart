import 'package:cz_app/widget/app/models/graph.dart';
import 'package:cz_app/widget/app/referral_dashboard/graphs/graph_widget.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/bottom.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/container.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/template.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/top.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cz_app/widget/app/referral_dashboard/data/graph_data.dart';
import 'package:nock/nock.dart';

void main() {
  final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();
  group('RefferalLineChart', () {
    testWidgets('should render a line chart', (tester) async {
      // Given
      final List<Graph> graph = [
        Graph(1, 1, 10, 5),
        Graph(2, 2, 20, 10),
        Graph(3, 3, 30, 15),
        Graph(4, 4, 40, 20),
        Graph(5, 5, 50, 25),
      ];

      final widget = MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: RefferalLineChart(
            isShowingMainData: true,
            graph: graph,
          ),
        ),
      );

      // When
      await tester.pumpWidget(widget);

      // Then
      expect(find.byType(LineChart), findsOneWidget);
    });


    test('should return correct spots for open referrals', () {
      // Given
      final List<Graph> graph = [
        Graph(1, 1, 10, 5),
        Graph(2, 2, 20, 10),
        Graph(3, 3, 30, 15),
        Graph(4, 4, 40, 20),
        Graph(5, 5, 50, 25),
      ];
      final widget = RefferalLineChart(
        isShowingMainData: true,
        graph: graph,
      );

      // When
      final spots = widget.getSpotsOpens;

      // Then
      expect(spots.length, graph.length);
      expect(spots[0].x, graph[0].Id.toDouble());
      expect(spots[0].y, graph[0].AmmountOfNewReferrals.toDouble());


      // Add more assertions as needed
    });

    test('should return correct spots for closed referrals', () {
      // Given
      final List<Graph> graph = [
        Graph(1, 1, 10, 5),
        Graph(2, 2, 20, 10),
        Graph(3, 3, 30, 15),
        Graph(4, 4, 40, 20),
        Graph(5, 5, 50, 25),
      ];
      final widget = RefferalLineChart(
        isShowingMainData: true,
        graph: graph,
      );

      // When
      final spots = widget.getSpotsCloseds;

      // Then
      expect(spots.length, graph.length);

      // Add more assertions as needed
    });
  });

  testWidgets('should render a line chart with referral data', (tester) async {
      await binding.setSurfaceSize(const Size(900, 900));
    // Given
    final mockGraphData = [
      Graph(1, 1, 10, 5),
      Graph(2, 2, 20, 10),
      Graph(3, 3, 30, 15),
      Graph(4, 4, 40, 20),
      Graph(5, 5, 50, 25),
    ];

    await tester.pumpWidget(
        const MaterialApp(
         home: Scaffold(
          body: ReferralDashboardTemplate(
            header: ReferralDashboardTopWidget(),
            body: ReferralDashboardBottomWidget(
              child: ReferralDashboardContainerWidget(
                child: LineChartSample())
            ,
          ),
        ),
      ),)
    );

    // Then
    final textFinder = find.text('Aandrachten');

    expect(textFinder, findsOneWidget);

  });


}