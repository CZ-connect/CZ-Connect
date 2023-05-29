import 'package:cz_app/widget/app/departments/data/department_data.dart';
import 'package:cz_app/widget/app/departments/services/delete_department.dart';
import 'package:cz_app/widget/app/models/department.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DepartmentIndex extends StatefulWidget {
  const DepartmentIndex({super.key});

  @override
  State<StatefulWidget> createState() => _DepartmentIndex();
}

class _DepartmentIndex extends State<DepartmentIndex> {
  late Future<List<Department>> departments;
  @override
  void initState() {
    departments = DepartmentData().fetchDepartments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Column(
          children: <Widget>[
            Text("Overzicht van alle afdelingen.",
                style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 40)),
            FutureBuilder<List<Department>>(
              future: departments,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('Er zijn geen afdelingen gevonden.');
                } else {
                  List<Department> departments =
                      snapshot.data as List<Department>;
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: DataTable(
                        dataRowHeight: 75,
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.grey),
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Expanded(
                              child: Text("Afdelingsnaam"),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(""),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(""),
                            ),
                          ),
                        ],
                        rows: buildRows(departments),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  List<DataRow> buildRows(List<Department> departments) {
    return List.generate(
      departments.length,
      (index) {
        final color = index % 2 == 0 ? Colors.grey[300] : Colors.white;
        return DataRow(
          color: MaterialStateProperty.all<Color>(color!),
          cells: <DataCell>[
            DataCell(
              Text(
                departments[index].departmentName,
              ),
            ),
            DataCell(editDepartmentButton()),
            DataCell(deleteDepartmentButton(departments[index])),
          ],
        );
      },
    );
  }

  ElevatedButton editDepartmentButton() {
    return ElevatedButton(
      key: const Key('edit_department_key'),
      onPressed: () {
        //edit department here
      },
      child: const Text("Edit"),
    );
  }

  ElevatedButton deleteDepartmentButton(Department department) {
    return ElevatedButton(
      key: const Key('delete_department_key'),
      child: const Text("Verwijderen"),
      onPressed: () async {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Afdeling verwijderen"),
              content: const Text(
                  "Weet u zeker dat u deze afdeling wilt gaan verwijderen?"),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: const Text("Verwijder"),
                  onPressed: () {
                    deleteDepartment(context, department.id);
                    setState(() {});
                    // deleteReferral(context, referral.id);
                    // if (widget.employeeReferral?.employee !=
                    //     null) {
                    //   context.go("/referraldashboard",
                    //       extra: employee);
                    // } else {
                    //   context.go("/recruitmentdashboard");
                    // }
                  },
                )
              ],
            );
          },
        );
      },
    );
  }
}
