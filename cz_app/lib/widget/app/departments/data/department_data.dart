import 'package:cz_app/widget/app/models/department.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DepartmentData {
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
      throw Exception(AppLocalizations.of(context)!.failedToRetrieveDepartments);
    }
  }
}
