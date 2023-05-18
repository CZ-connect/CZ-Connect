import 'package:cz_app/widget/app/recruitment_dashboard/data/recruitment_data.dart';
import 'package:cz_app/widget/app/models/department.dart';
import 'package:cz_app/widget/app/models/employee.dart';
import 'package:cz_app/widget/app/models/employee_referral.dart';
import 'package:cz_app/widget/app/models/referral.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

void main() => runApp(const RecruitmentDashboardIndexWidget());

class RecruitmentDashboardIndexWidget extends StatefulWidget {
  const RecruitmentDashboardIndexWidget({super.key});

  @override
  State<StatefulWidget> createState() => _RecruitmentDashboard();
}

class _RecruitmentDashboard extends State<RecruitmentDashboardIndexWidget> {
  late Future<List<Department>> departments;
  late Future<List<Employee>> employees;
  late Future<List<Referral>> unlinkedReferrals;

  @override
  void initState() {
    unlinkedReferrals = RecruitmentData().fetchUnlinkedReferrals();
    departments = RecruitmentData().fetchDepartments();
    employees = RecruitmentData().fetchEmployees(1);
    super.initState();
  }

  bool showDepartments = false;
  int selectedDepartment = 0;

  void toggleExpansion() {
    setState(() {
      showDepartments = !showDepartments;
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
    return SizedBox.expand(
      child: Column(
        children: [
          Flexible(
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Flexible(child: recruimentTableButtonRow()),
              ],
            ),
          ),
          Flexible(
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Flexible(
                  child: showDepartments
                      ? referralsPerDepartmentTable()
                      : unlinkedReferralsTable(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget recruimentTableButtonRow() {
    return FutureBuilder<List<Department>>(
      future: departments,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No departments found.');
        } else {
          List<Department> departments = snapshot.data as List<Department>;
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: GridView.count(
              childAspectRatio:
                  MediaQuery.of(context).size.width / (departments.length * 75),
              crossAxisCount: departments.length + 1,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    key: const Key('departmentButton'),
                    onPressed: () {
                      if (showDepartments) {
                        toggleExpansion();
                      }
                    },
                    child: const Text("Open sollicitaties"),
                  ),
                ),
                for (Department department in departments)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      key: const Key('departmentButton'),
                      onPressed: () {
                        if (!showDepartments) {
                          toggleExpansion();
                        }
                        selectDepartment(department.id);
                      },
                      child: Text(department.departmentName),
                    ),
                  ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget referralsPerDepartmentTable() {
    return FutureBuilder<List<Employee>>(
      future: employees,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No employees found.');
        } else {
          List<Employee> employees = snapshot.data as List<Employee>;
          return buildDepartmentTable(employees);
        }
      },
    );
  }

  Widget buildDepartmentTable(List<Employee> employees) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columns: buildDepartmentColumns(),
          rows: buildDepartmentRows(employees),
        ),
      ),
    );
  }

  List<DataColumn> buildDepartmentColumns() {
    return <DataColumn>[
      const DataColumn(label: Text("Medewerker")),
      const DataColumn(label: Text("Email")),
      const DataColumn(label: Text("Referrals"))
    ];
  }

  List<DataRow> buildDepartmentRows(List<Employee> employees) {
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

  Widget unlinkedReferralsTable() {
    return FutureBuilder<List<Referral>>(
      future: unlinkedReferrals,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('Op dit moment zijn er geen open sollicitaties.');
        } else {
          List<Referral> referrals = snapshot.data as List<Referral>;
          return buildUnlinkedTable(referrals);
        }
      },
    );
  }

  Widget buildUnlinkedTable(List<Referral> referrals) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columns: buildUnlinkedColumns(),
          rows: buildUnlinkedRows(referrals),
        ),
      ),
    );
  }

  List<DataColumn> buildUnlinkedColumns() {
    return <DataColumn>[
      const DataColumn(label: Text("Naam")),
      const DataColumn(label: Text("Status")),
      const DataColumn(label: Text("Linkedin")),
      const DataColumn(label: Text("Gesolliciteerd op"))
    ];
  }

  List<DataRow> buildUnlinkedRows(List<Referral> referrals) {
    return List.generate(
      referrals.length,
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
                    referrals[index].participantName,
                    style: const TextStyle(color: Colors.blueAccent),
                  ),
                  onTap: () {
                    context.go(
                      "/referraldetail",
                      extra: EmployeeReferralViewModel(null, referrals[index]),
                    );
                  },
                ),
              ),
            ),
            DataCell(
              Text(referrals[index].linkedin ?? "-"),
              onTap: () {
                Clipboard.setData(
                    ClipboardData(text: referrals[index].linkedin ?? ""));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Link copied to clipboard")),
                );
              },
            ),
            DataCell(Text(referrals[index].status)),
            DataCell(Text(DateFormat('d, MMM, yyyy')
                .format(referrals[index].registrationDate))),
          ],
        );
      },
    );
  }
}
