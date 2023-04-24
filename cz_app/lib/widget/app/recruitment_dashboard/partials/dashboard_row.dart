import 'package:cz_app/widget/app/models/employee.dart';
import 'package:cz_app/widget/app/recruitment_dashboard/data/recruitment_data.dart';
import '../../models/department.dart' show Department;
import 'package:flutter/material.dart';

class DashboardRow extends StatefulWidget {
  const DashboardRow({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardRow();
}

class _DashboardRow extends State<DashboardRow> {
  late Future<List<Department>> departments;
  late Future<List<Employee>> employees;

  @override
  void initState() {
    departments = RecruitmentData().fetchDepartments();
    employees = RecruitmentData().fetchEmployees(1);
    super.initState();
  }

  bool isExpanded = false;
  int selectedDepartment = 0;

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void selectDepartment(int departmentId) {
    setState(() {
      selectedDepartment = departmentId;
      employees = RecruitmentData().fetchEmployees(departmentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Departments',
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        FutureBuilder<List<Department>>(
          future: departments,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No departments found.');
            } else {
              return Wrap(
                children: snapshot.data!
                    .map(
                      (dept) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () => selectDepartment(dept.id),
                          child: Text(dept.departmentName),
                        ),
                      ),
                    )
                    .toList(),
              );
            }
          },
        ),
        Expanded(
          child: FutureBuilder<List<Employee>>(
            future: employees,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No departments found.');
              } else {
                List<Employee> employees = snapshot.data!;
                return ListView.builder(
                  itemCount: employees.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(employees[index].name),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
