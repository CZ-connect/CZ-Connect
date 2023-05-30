import 'package:cz_app/widget/app/models/department.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;

class DepartmentData {
  Future<List<Department>> fetchDepartments() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/department'));

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
