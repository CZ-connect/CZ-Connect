import 'package:cz_app/widget/app/models/department.dart';
import 'package:cz_app/widget/app/models/employee.dart';
import 'package:cz_app/widget/app/models/referral.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class RecruitmentData {
  Future<List<Department>> fetchDepartments(BuildContext context) async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/department'));

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
    final response = await http.get(
        Uri.parse(
            'http://localhost:3000/api/employee/department/$departmentId'),
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
      throw Exception(AppLocalizations.of(context)!.fetchEmployeesError);
    }
  }

  Future<List<Referral>> fetchUnlinkedReferrals(BuildContext context) async {
    final response = await http
        .get(Uri.parse('http://localhost:3000/api/referral/unlinked'));
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
