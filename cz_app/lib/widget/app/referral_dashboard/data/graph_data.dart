import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/graph.dart';

Future<List<Graph>> fetchGraphData() async {
  final response =
      await http.get(Uri.parse('http://localhost:3000/api/graphdata'));
  if (response.statusCode == 200) {
    var graphJson = jsonDecode(response.body)["graph_data"] as List;
    List<Graph> graph = graphJson.map((e) => Graph.fromJson(e)).toList();
    return graph;
  } else {
    throw Exception('Grafiek data ophalen vanuit de backend is mislukt.');
  }
}
