import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../models/graph.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<List<Graph>> fetchGraphData(BuildContext context) async {
  var host = dotenv.env['API_URL'];
  var route = '/api/graphdata';
  var url = Uri.http(host!, route);
  if(host.isEmpty) {
    url = Uri.https('flutter-backend.azurewebsites.net', route);
  }

  final response =
      await http.get(url);
  if (response.statusCode == 200) {
    var graphJson = jsonDecode(response.body)["graph_data"] as List;
    List<Graph> graph = graphJson.map((e) => Graph.fromJson(e)).toList();
    return graph;
  } else {
    throw Exception(AppLocalizations.of(context)?.fetchChartDataError ?? '');
  }
}
