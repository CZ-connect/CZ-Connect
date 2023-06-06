import 'package:cz_app/widget/app/models/department.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;

class DepartmentData {
  Future<List<Department>> fetchDepartments() async {
    var host = dotenv.env['API_URL'] ?? 'flutter-backend.azurewebsites.net';
    var route = '/api/department';
    var url = Uri.http(host, route);
    if(host != dotenv.env['API_URL']) {
      url = Uri.https(host, route);
    }
    final response =
        await http.get(url);

    if (response.statusCode == 200) {
      var departmentObjsJson = jsonDecode(response.body) as List;
      List<Department> departmentObjs = departmentObjsJson
          .map((departmentJson) => Department.fromJson(departmentJson))
          .toList();

      return departmentObjs;
    } else {
      throw Exception('Afdelingen ophalen vanuit de backend is mislukt.');
    }
  }
}
