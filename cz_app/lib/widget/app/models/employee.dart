class Employee {
  int id;
  int departmentId;
  String name;
  String email;
  int? referralCount;

  Employee(
      {required this.id,
      required this.departmentId,
      required this.name,
      required this.email,
      this.referralCount});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
        id: json['employee']['id'],
        departmentId: json['employee']['departmentId'],
        name: json['employee']['employeeName'],
        email: json['employee']['employeeEmail'],
        referralCount: json['referralCount']);
  }
}
