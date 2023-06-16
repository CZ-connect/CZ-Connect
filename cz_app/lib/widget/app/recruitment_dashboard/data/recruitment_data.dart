import 'package:cz_app/widget/app/models/department.dart';
import 'package:cz_app/widget/app/models/employee.dart';
import 'package:cz_app/widget/app/models/referral.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class RecruitmentData {
  Future<List<Department>> fetchDepartments(BuildContext context) async {
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
      throw Exception(AppLocalizations.of(context)!.fetchDepartmentsError);
    }
  }

  Future<List<Employee>> fetchEmployees(int departmentId, BuildContext context) async {
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
      throw Exception(AppLocalizations.of(context)!.fetchEmployeesError);
    }
  }


  Future<int> completedCounter(int departmentId) async {
    var host = dotenv.env['API_URL'];
    var route = 'api/employee/department/$departmentId';
    var url = Uri.http(host!, route);
    if(host.isEmpty) {
      var response = await http.get(Uri.parse(
          'https://flutter-backend.azurewebsites.net/api/employee/department/$departmentId'));
      return jsonDecode(response.body)["pendingReferrals"];
    }
    var response = await http.get(Uri.parse(
        'http://localhost:3000/api/employee/department/$departmentId'));

    return jsonDecode(response.body)["completedReferrals"];
  }

  Future<int> pendingCounter(int departmentId) async {
    var host = dotenv.env['API_URL'];
    var route = 'api/employee/department/$departmentId';
    var url = Uri.http(host!, route);
    if(host.isEmpty) {
      var response = await http.get(Uri.parse(
          'https://flutter-backend.azurewebsites.net/api/employee/department/$departmentId'));
      return jsonDecode(response.body)["pendingReferrals"];
    }
   var response = await http.get(Uri.parse(
        'http://localhost:3000/api/employee/department/$departmentId'));

    return jsonDecode(response.body)["pendingReferrals"];
  }

  Future<List<Referral>> fetchUnlinkedReferrals(BuildContext context) async {
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
      throw Exception(AppLocalizations.of(context)!.fetchReferralsError);
    }
  }
}
