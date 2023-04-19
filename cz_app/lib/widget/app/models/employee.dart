class Employee {
  int id;
  int departmentId;
  String? name;
  String? email;

  Employee(
      {required this.id,
      required this.departmentId,
      required this.name,
      required this.email});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      departmentId: json['departmentId'],
      name: json['name'],
      email: json['email'],
    );
  }
}
