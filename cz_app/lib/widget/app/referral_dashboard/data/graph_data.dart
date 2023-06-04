import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../models/graph.dart';

Future<List<Graph>> fetchGraphData() async {
  var url = Uri.http(dotenv.env['API_URL'] ?? 'flutter-backend.azurewebsites.net', '/api/graphdata');
  final response =
      await http.get(url);
  if (response.statusCode == 200) {
    var graphJson = jsonDecode(response.body)["graph_data"] as List;
    List<Graph> graph = graphJson.map((e) => Graph.fromJson(e)).toList();
    return graph;
  } else {
    throw Exception('Grafiek data ophalen vanuit de backend is mislukt.');
  }
}
