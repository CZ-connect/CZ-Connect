class Employee {
  int id;
  int departmentId;
  String name;
  String email;
  int? referralCount;

  String? role;
  Employee(
      {required this.id,
      required this.departmentId,
      required this.name,
      required this.email,
      this.role,
      this.referralCount});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
        id: json['employee']['id'],
        departmentId: json['employee']['departmentId'],
        name: json['employee']['employeeName'],
        email: json['employee']['employeeEmail'],
        role: json['employee']['role'] as String?,
        referralCount: json['referralCount']);
  }
}
