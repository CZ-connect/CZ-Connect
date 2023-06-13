import 'package:cz_app/widget/app/models/department.dart';
import 'package:cz_app/widget/app/models/employee.dart';
import 'package:cz_app/widget/app/models/referral.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;

class RecruitmentData {
  Future<List<Department>> fetchDepartments() async {
    var host = dotenv.env['API_URL'];
    var route = '/api/department';
    var url = Uri.http(host!, route);
    if(host.isEmpty) {
      url = Uri.https('flutter-backend.azurewebsites.net', route);
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

  Future<List<Employee>> fetchEmployees(int departmentId) async {
    var host = dotenv.env['API_URL'];
    var route = '/api/employee/department/$departmentId';
    var url = Uri.http(host!, route);
    if(host.isEmpty) {
      url = Uri.https('flutter-backend.azurewebsites.net', route);
    }
    
    final response = await http.get(
        url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        });

    if (response.statusCode == 200) {
      final parsedResponse = jsonDecode(response.body);

      if (parsedResponse.containsKey("employeeWithCounters")) {
        final employeeObjsJson = parsedResponse["employeeWithCounters"] as List;
        final employeeObjs = employeeObjsJson
            .map((employeeJson) => Employee.fromJson(employeeJson))
            .toList();
        return employeeObjs;
      } else {
        throw Exception(
            'Invalid JSON response: employeeWithCounters not found');
      }
    } else {
      throw Exception('Medewerkers ophalen vanuit de backend is mislukt.');
    }
  }

  Future<int> completedCounter(int departmentId) async {
    final response = await http.get(Uri.parse(
        'http://localhost:3000/api/employee/department/$departmentId'));

    return jsonDecode(response.body)["completedReferrals"];
  }

  Future<int> pendingCounter(int departmentId) async {
    final response = await http.get(Uri.parse(
        'http://localhost:3000/api/employee/department/$departmentId'));

    return jsonDecode(response.body)["pendingReferrals"];
  }

  Future<List<Referral>> fetchUnlinkedReferrals() async {
    var host = dotenv.env['API_URL'];
    var route = '/api/referral/unlinked';
    var url = Uri.http(host!, route);
    if(host.isEmpty) {
      url = Uri.https('flutter-backend.azurewebsites.net', route);
    }
    
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
