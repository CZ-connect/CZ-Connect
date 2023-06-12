import 'package:cz_app/widget/app/models/department.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DepartmentData {
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
      //throw Exception();
      throw Exception(AppLocalizations.of(context)!.failedToRetrieveDepartments);
    }
  }
}
