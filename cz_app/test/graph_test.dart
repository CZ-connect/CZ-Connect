import 'package:cz_app/widget/app/models/graph.dart';
import 'package:cz_app/widget/app/referral_dashboard/graphs/graph_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cz_app/widget/app/referral_dashboard/data/graph_data.dart';

void main() {
  group('RefferalLineChart', () {
    testWidgets('should render a line chart', (tester) async {
      // Given
      final List<Graph> graph = GraphData().fetchGraph();
      final widget = RefferalLineChart(
        isShowingMainData: true,
        graph: graph,
      );

      // When
      await tester.pumpWidget(widget);

      // Then
      expect(find.byType(LineChart), findsOneWidget);
    });

    test('should return correct spots for open referrals', () {
      // Given
      final List<Graph> graph = GraphData().fetchGraph();
      final widget = RefferalLineChart(
        isShowingMainData: true,
        graph: graph,
      );

      // When
      final spots = widget.getSpotsOpens;

      // Then
      expect(spots.length, graph.length);
      expect(spots[0].x, graph[0].Id.toDouble());
      expect(spots[0].y, graph[0].AmmountOfNewReferrals.toDouble() / 10);
      // Add more assertions as needed
    });

    test('should return correct spots for closed referrals', () {
      // Given
      final List<Graph> graph = GraphData().fetchGraph();
      final widget = RefferalLineChart(
        isShowingMainData: true,
        graph: graph,
      );

      // When
      final spots = widget.getSpotsCloseds;

      // Then
      expect(spots.length, graph.length);
      expect(spots[0].x, graph[0].Id.toDouble());
      expect(spots[0].y, graph[0].AmmountOfApprovedReferrals.toDouble() / 10);
      // Add more assertions as needed
    });
  });
}
