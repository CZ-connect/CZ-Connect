import 'package:cz_app/widget/app/recruitment_dashboard/data/recruitment_data.dart';
import 'package:cz_app/widget/app/models/department.dart';
import 'package:cz_app/widget/app/models/employee.dart';
import 'package:cz_app/widget/app/models/employee_referral.dart';
import 'package:cz_app/widget/app/models/referral.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() => runApp(const RecruitmentDashboardIndexWidget());

class RecruitmentDashboardIndexWidget extends StatefulWidget {
  const RecruitmentDashboardIndexWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecruitmentDashboardState();
}

class _RecruitmentDashboardState extends State<RecruitmentDashboardIndexWidget> {
  late Future<List<Department>> departments;
  late Future<List<Employee>> employees;
  late Future<List<Referral>> unlinkedReferrals;
  late Future<int> completedCounter;
  late Future<int> pendingCounter;

  @override
  void initState() {
    unlinkedReferrals = RecruitmentData().fetchUnlinkedReferrals();
    departments = RecruitmentData().fetchDepartments();
    employees = RecruitmentData().fetchEmployees(1);
    completedCounter = RecruitmentData().completedCounter(1);
    pendingCounter = RecruitmentData().pendingCounter(1);
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
      completedCounter = RecruitmentData().completedCounter(departmentId);
      pendingCounter = RecruitmentData().pendingCounter(departmentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final maxHeight = constraints.maxHeight;

      return SizedBox.expand(
        child: Column(
          children: [
            Container(
              child: Flexible(
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Flexible(
                      child: recruimentTableButtonRow(),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Row(
                children: [
                  Flexible(
                    child: referralCounters(),
                  ),
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
    });
  }

  Widget recruimentTableButtonRow() {
    return FutureBuilder<List<Department>>(
      future: departments,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text(AppLocalizations.of(context)?.fetchDepartmentsError ?? '');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text(AppLocalizations.of(context)?.noDepartmentsFound ?? '');
        } else {
          List<Department> departments = snapshot.data!;
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
                    child: Text(AppLocalizations.of(context)?.openApplicationsButton ?? ''),
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

  Widget referralCounters() {
    final referralCompleted = Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
          border: Border.all(width: 2),
          shape: BoxShape.circle,
          color: Colors.redAccent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: completedCounter,
            builder: (context, snapshot) {
              return Text("${snapshot.data}");
            },
          ),
        ],
      ),
    );

    final referralPending = Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
          border: Border.all(width: 2),
          shape: BoxShape.circle,
          color: Colors.redAccent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: pendingCounter,
            builder: (context, snapshot) {
              return Text("${snapshot.data}");
            },
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: FractionallySizedBox(
        widthFactor: 1.0,
        heightFactor: 0.3,
        alignment: FractionalOffset.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(child: referralCompleted),
                  const Text('Goedgekeurd')
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(child: referralPending),
                  const Text('In Afwachting')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget referralsPerDepartmentTable() {
    return FutureBuilder<List<Employee>>(
      future: employees,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text(AppLocalizations.of(context)?.fetchEmployeesError ?? '');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text(AppLocalizations.of(context)?.noEmployeesFound ?? '');
        } else {
          List<Employee> employees = snapshot.data!;
          return buildDepartmentTable(employees);
        }
      },
    );
  }

  Widget buildDepartmentTable(List<Employee> employees) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 700,
        child: DataTable(
          columns: buildDepartmentColumns(),
          rows: buildDepartmentRows(employees),
        ),
      ),
    );
  }

  List<DataColumn> buildDepartmentColumns() {
    return <DataColumn>[
      DataColumn(label: Text(AppLocalizations.of(context)?.employeeLabel ?? '')),
      DataColumn(label: Text(AppLocalizations.of(context)?.emailLabel ?? '')),
      DataColumn(label: Text(AppLocalizations.of(context)?.referralCountLabel ?? '')),
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
            DataCell(Text("${AppLocalizations.of(context)?.referralCountPrefix} ${employees[index].referralCount}")),
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
          return Text(AppLocalizations.of(context)?.fetchReferralsError ?? '');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text(AppLocalizations.of(context)?.noOpenReferrals ?? '');
        } else {
          List<Referral> referrals = snapshot.data!;
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
      DataColumn(label: Text(AppLocalizations.of(context)?.nameLabel ?? '')),
      DataColumn(label: Text(AppLocalizations.of(context)?.statusLabel ?? '')),
      DataColumn(label: Text(AppLocalizations.of(context)?.linkedinLabel ?? '')),
      DataColumn(label: Text(AppLocalizations.of(context)?.applicationDateLabel ?? '')),
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
            DataCell(Text(referrals[index].translateStatus(context))),
            DataCell(
              Text(referrals[index].linkedin ?? "-"),
              onTap: () {
                Clipboard.setData(
                    ClipboardData(text: referrals[index].linkedin ?? ""));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                  content: Text(AppLocalizations.of(context)?.linkCopiedMessage ?? '')),
                );
              },
            ),
            DataCell(Text(DateFormat('d, MMM, yyyy')
                .format(referrals[index].registrationDate))),
          ],
        );
      },
    );
  }
}