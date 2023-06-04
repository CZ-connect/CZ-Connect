import 'package:cz_app/widget/app/models/department.dart';
import 'package:cz_app/widget/app/models/employee.dart';
import 'package:cz_app/widget/app/models/referral.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;

class RecruitmentData {
  Future<List<Department>> fetchDepartments() async {
   var url = Uri.http(dotenv.env['API_URL'] ?? 'https://czbackendweb.scm.azurewebsites.net', '/api/department');
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

  Future<List<Employee>> fetchEmployees(int departmentId) async {
    var url = Uri.http(dotenv.env['API_URL'] ?? 'https://czbackendweb.scm.azurewebsites.net', '/api/employee/department/$departmentId');
    final response = await http.get(
        url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        });

    if (response.statusCode == 200) {
      var employeeObjsJson = jsonDecode(response.body) as List;
      List<Employee> employeeObjs = employeeObjsJson
          .map((employeeJson) => Employee.fromJson(employeeJson))
          .toList();
      return employeeObjs;
    } else {
      throw Exception('Medewerkers ophalen vanuit de backend is mislukt.');
    }
  }

  Future<List<Referral>> fetchUnlinkedReferrals() async {
    var url = Uri.http(dotenv.env['API_URL'] ?? 'https://czbackendweb.scm.azurewebsites.net', '/api/referral/unlinked');
    final response = await http
        .get(url);
    if (response.statusCode == 200) {
      var unlinkedReferrals =
          jsonDecode(response.body)['referral_data'] as List;
      List<Referral> referrals =
          unlinkedReferrals.map((r) => Referral.fromJson(r)).toList();
      return referrals;
    } else {
      throw Exception(
          'Open sollicitaties ophalen vanuit de backend is mislukt.');
    }
  }
}
