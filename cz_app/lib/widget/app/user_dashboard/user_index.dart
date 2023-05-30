import 'dart:convert';

import 'package:cz_app/widget/app/user_dashboard/user_update_form.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/department.dart';
import '../models/user.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _State();
}

class _State extends State<UserDashboard> {
  List<User> users = [];
  List<Department> departments = [];
  TextEditingController searchController = TextEditingController();
  List<User> filteredUsers = [];
  List<User> allUsers = [];
  bool showUnverified = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    await fetchDepartments();
    await fetchUsers();
  }

  Future<void> refreshUsers() async {
    setState(() {
      filteredUsers = [];
      allUsers = [];
    });
    await fetchUsers();
  }

  Future<void> removeUser(User user) async {
    await http
        .delete(Uri.parse('http://localhost:3000/api/employee/${user.id}'));
    refreshUsers();
  }

  Future<void> verifyOrUnVerify(User user) async {
    if (user.verified) {
      await http.post(
          Uri.parse('http://localhost:3000/api/employee/${user.id}/unverify'));
    } else {
      await http.post(
          Uri.parse('http://localhost:3000/api/employee/${user.id}/verify'));
    }
    refreshUsers();
  }

  Future<bool?> showRemoveUserPrompt(User user) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Gebruiker verwijderen'),
          content:
              const Text('Weet u zeker dat u de gebruiker wilt verwijderen?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Nee'),
            ),
            ElevatedButton(
              onPressed: () {
                removeUser(user);
                Navigator.of(context).pop(true);
              },
              child: const Text('Ja'),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> showUpdateUserPrompt(User user) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: UserUpdateWidget(user: user),
        );
      },
    );
    if (result == true) {
      refreshUsers();
    }
    return result;
  }

  Future<void> fetchUsers() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/employee/'));
    final jsonData = json.decode(response.body);
    List<User> fetchedUsers = [];
    for (var data in jsonData) {
      User user = User.fromJson(data);
      if (user.departmentId != null) {
        Department department =
            departments.firstWhere((dep) => dep.id == user.departmentId);
        user.department = department.departmentName;
      } else {
        user.department == null;
      }
      fetchedUsers.add(user);
    }
    setState(() {
      users = fetchedUsers;
      filteredUsers = List.from(users);
      allUsers = List.from(users);
    });
  }

  Future<void> fetchDepartments() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/department/'));
    final jsonData = json.decode(response.body);
    List<Department> fetchedDepartments = [];
    for (var data in jsonData) {
      Department department = Department.fromJson(data);
      fetchedDepartments.add(department);
    }
    if (fetchedDepartments.isNotEmpty) {
      setState(() {
        departments = fetchedDepartments;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void searchUsers(String searchTerm) {
      // setState(() {
      //   filteredUsers = allUsers.where((user) {
      //     final searchTermLowerCase = searchTerm.toLowerCase();
      //     final verifiedText = user.verified ? 'ja' : 'nee';
      //     return (user.name.toLowerCase().contains(searchTermLowerCase) ||
      //             user.email.toLowerCase().contains(searchTermLowerCase) ||
      //             verifiedText.toLowerCase().contains(searchTermLowerCase) ||
      //             (user.role.toLowerCase().contains(searchTermLowerCase) ??
      //                 false) ||
      //             user.department!
      //                 .toLowerCase()
      //                 .contains(searchTermLowerCase) ??
      //         false);
      //   }).toList();
      // });
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    searchUsers(value);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Zoeken',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Rest of the code...
        if (filteredUsers.isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (BuildContext context, int index) {
                User user = filteredUsers[index];
                return Column(children: [
                  ListTile(
                    title: Text(user.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.email),
                        Text(
                            'Afdeling: ${user.department ?? 'Niet van toepassing'}'),
                        Text('Geverifieerd: ${user.verified ? 'Ja' : 'Nee'}'),
                        Text('Rol: ${user.role ?? 'Niet van toepassing'}'),
                      ],
                    ),
                    trailing: Wrap(
                      spacing: 2,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showRemoveUserPrompt(user);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black38,
                          ),
                          child: Text('Verwijderen'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showUpdateUserPrompt(user);
                          },
                          child: Text('Aanpassen'),
                        ),
                        SizedBox(
                          width: 120,
                          child: ElevatedButton(
                            onPressed: () {
                              verifyOrUnVerify(user);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: (user.verified) ? Colors.black38 : null,
                            ),
                            child: Text((user.verified)
                                ? "Onverifiëren"
                                : "Verifiëren"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider()
                ]);
              },
            ),
          )
        else
          const Padding(
            padding: EdgeInsets.all(50.0),
            child: Center(child: Text('Geen data gevonden')),
          ),
      ],
    );
  }
}
