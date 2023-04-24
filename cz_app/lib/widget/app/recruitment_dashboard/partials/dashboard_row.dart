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
  @override
  void initState() {
    departments = RecruitmentData().fetchDepartments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Department>>(
      future: departments,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: true,
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(label: Expanded(child: Text("Naam")))
                    ],
                    rows: snapshot.data!.map<DataRow>(
                      (department) {
                        return DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Text(department.departmentName),
                            ),
                          ],
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            );
          } else {
            return const Text('No departments found!');
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
