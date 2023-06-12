import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../models/graph.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


Future<List<Graph>> fetchGraphData(BuildContext context) async {
  final response =
      await http.get(Uri.parse('http://localhost:3000/api/graphdata'));
  if (response.statusCode == 200) {
    var graphJson = jsonDecode(response.body)["graph_data"] as List;
    List<Graph> graph = graphJson.map((e) => Graph.fromJson(e)).toList();
    return graph;
  } else {
    throw Exception(AppLocalizations.of(context)?.fetchChartDataError ?? '');
  }
}
