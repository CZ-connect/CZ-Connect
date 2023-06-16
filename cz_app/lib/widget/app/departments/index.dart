import 'package:cz_app/widget/app/departments/data/department_data.dart';
import 'package:cz_app/widget/app/departments/services/delete_department.dart';
import 'package:cz_app/widget/app/models/department.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DepartmentIndex extends StatefulWidget {
  const DepartmentIndex({Key? key}) : super(key: key);

  @override
  _DepartmentIndexState createState() => _DepartmentIndexState();
}

class _DepartmentIndexState extends State<DepartmentIndex> {
  late Future<List<Department>> departments;

  @override
  void initState() {
    departments = DepartmentData().fetchDepartments(context);
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
                    AppLocalizations.of(context)!.departmentOverviewText ?? '',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
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
                        return Text(
                          AppLocalizations.of(context)?.noDepartmentsFoundText ?? '',
                        );
                      } else {
                        List<Department> departments = snapshot.data!;
                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: DataTable(
                              dataRowHeight: 75,
                              headingRowColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.grey),
                              columns: <DataColumn>[
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)?.departmentNameColumnText ?? '',
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(''),
                                  ),
                                ),
                                DataColumn(
                                  label: ElevatedButton(
                                    key: const Key('new_department_key'),
                                    onPressed: () {
                                      context.go('/department/create');
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)?.newDepartmentButtonText ?? '',
                                    ),
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
        context.goNamed(
          'editDepartment',
          params: {'id': department.id.toString()},
          extra: department,
        );
      },
      child: Text(
        AppLocalizations.of(context)?.editButtonText ?? '',
      ),
    );
  }

  ElevatedButton deleteDepartmentButton(Department department) {
    return ElevatedButton(
      key: const Key('delete_department_key'),
      child: Text(
        AppLocalizations.of(context)?.deleteButtonText ?? '',
      ),
      onPressed: () async {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                AppLocalizations.of(context)?.deleteDepartmentDialogTitle ?? '',
              ),
              content: Text(
                AppLocalizations.of(context)?.deleteDepartmentDialogMessage ?? '',
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  child: Text(
                    AppLocalizations.of(context)?.deleteDepartmentDialogCancelButtonText ?? '',
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: Text(
                    AppLocalizations.of(context)?.deleteDepartmentDialogDeleteButtonText ?? '',
                  ),
                  onPressed: () async {
                    await deleteDepartment(context, department.id);
                    setState(() {
                      Navigator.of(context).pop(true);
                      departments = DepartmentData().fetchDepartments(context);
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
