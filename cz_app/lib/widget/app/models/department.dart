class Department {
  int id;
  String departmentName;

  Department({required this.id, required this.departmentName});

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(id: json['id'], departmentName: json['departmentName']);
  }
}
