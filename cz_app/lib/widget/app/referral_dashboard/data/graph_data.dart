import 'dart:convert' show jsonDecode;
import 'dart:io';
import 'package:cz_app/widget/app/models/graph.dart';
import 'package:http/http.dart' as http;

class GraphData {
  Future<List<Graph>> fetchGraph() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/graphdata'));
    if (response.statusCode == 200) {
      var graphJson = jsonDecode(response.body)["graph_data"] as List;
      List<Graph> graph = graphJson.map((e) => Graph.fromJson(e)).toList();
      return graph;
    } else {
      throw Exception('Failed to load Graph');
    }
  }
}
