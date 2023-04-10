import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/employee.dart';

class EmployeeData {
  Future<Employee> fetchEmployee() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/employee/1'));

    if (response.statusCode == 200) {
      // If the server did return a successful response, then parse the JSON.
      return Employee.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a successful response, then throw an exception.
      throw Exception('Failed to load employee');
    }
  }
}
