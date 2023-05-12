import 'package:cz_app/widget/app/models/employee.dart';
import 'package:cz_app/widget/app/recruitment_dashboard/data/recruitment_data.dart';
import 'package:go_router/go_router.dart';
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

  List<DataColumn> buildColumns() {
    return <DataColumn>[
      const DataColumn(label: Text("Medewerker")),
      const DataColumn(label: Text("Email")),
      const DataColumn(label: Text("Referrals"))
    ];
  }

  List<DataRow> buildRows(List<Employee> employees) {
    return List.generate(
      employees.length,
      (index) {
        final color = index % 2 == 0 ? Colors.grey[300] : Colors.white;
        return DataRow(
          color: MaterialStateProperty.all<Color>(color!),
          cells: [
            DataCell(
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  child: Text(
                    employees[index].name,
                    style: const TextStyle(color: Colors.blueAccent),
                  ),
                  onTap: () {
                    context.go("/referraldashboard", extra: employees[index]);
                  },
                ),
              ),
            ),
            DataCell(Text(employees[index].email)),
            DataCell(Text("Referrals: ${employees[index].referralCount}")),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: Future.wait([departments, employees]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No departments found.');
        } else {
          List<Department> departments = snapshot.data![0] as List<Department>;
          List<Employee> employees = snapshot.data![1] as List<Employee>;
          return Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: GridView.count(
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (departments.length * 35),
                  crossAxisCount: departments.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: departments.map((department) {
                    return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton(
                          key: const Key('departmentButton'),
                          onPressed: () {
                            selectDepartment(department.id);
                          },
                          child: Text(department.departmentName),
                        ));
                  }).toList(),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    key: const Key('departmentButton'),
                    onPressed: () {
                      //run stored procedure
                    },
                    child: const Text("Unlinked referrals"),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: DataTable(
                    columnSpacing: 100,
                    dataRowHeight: 56,
                    columns: buildColumns(),
                    rows: buildRows(employees),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
