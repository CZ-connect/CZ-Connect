import 'package:cz_app/widget/app/models/department.dart';
import 'package:cz_app/widget/app/models/employee.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;

class RecruitmentData {
  Future<List<Department>> fetchDepartments() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/department'));

    if (response.statusCode == 200) {
      var departmentObjsJson = jsonDecode(response.body)['departments'] as List;
      List<Department> departmentObjs = departmentObjsJson
          .map((departmentJson) => Department.fromJson(departmentJson))
          .toList();
      return departmentObjs;
    } else {
      throw Exception('Failed to load departments');
    }
  }

  Future<List<Employee>> fetchEmployees() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/employee'));

    if (response.statusCode == 200) {
      var employeeObjsJson = jsonDecode(response.body)['departments'] as List;
      List<Employee> employeeObjs = employeeObjsJson
          .map((employeeJson) => Employee.fromJson(employeeJson))
          .toList();
      return employeeObjs;
    } else {
      throw Exception('Failed to load departments');
    }
  }

  Future<int> fetchReferralsPerEmployee() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/employee'));
    return jsonDecode(response.body)['referralCounter'];
  }
}
