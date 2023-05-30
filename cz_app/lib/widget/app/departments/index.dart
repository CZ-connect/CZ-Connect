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
    return SizedBox.expand(
      child: Column(
        key: const Key('Department_index_key'),
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    "Overzicht van alle afdelingen.",
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                )
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: [
                Flexible(
                  child: FutureBuilder<List<Department>>(
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
                              columns: <DataColumn>[
                                const DataColumn(
                                  label: Expanded(
                                    child: Text("Afdelingsnaam"),
                                  ),
                                ),
                                const DataColumn(
                                  label: Expanded(
                                    child: Text(""),
                                  ),
                                ),
                                DataColumn(
                                  label: ElevatedButton(
                                    key: const Key('new_department_key'),
                                    onPressed: () {
                                      context.go('/department/create');
                                    },
                                    child: const Text("Nieuwe afdeling"),
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
                ),
              ],
            ),
          ),
        ],
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
            DataCell(editDepartmentButton(departments[index])),
            DataCell(deleteDepartmentButton(departments[index])),
          ],
        );
      },
    );
  }

  ElevatedButton editDepartmentButton(Department department) {
    return ElevatedButton(
      key: const Key('edit_department_key'),
      onPressed: () {
        context.goNamed('editDepartment',
            params: {'id': department.id.toString()}, extra: department);
      },
      child: const Text("Bewerken"),
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
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: const Text("Verwijder"),
                  onPressed: () async {
                    await deleteDepartment(context, department.id);
                    setState(() {
                      Navigator.of(context).pop(true);
                      departments = DepartmentData().fetchDepartments();
                    });
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
