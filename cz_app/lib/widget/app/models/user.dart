class User {
  int id;
  int? departmentId;
  String? department;
  String name;
  String email;
  String role;
  bool verified;

  User({
    required this.id,
    this.departmentId,
    this.department,
    required this.name,
    required this.email,
    required this.role,
    required this.verified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      departmentId: json['departmentId'],
      name: json['employeeName'],
      email: json['employeeEmail'],
      role: json['role'] as String,
      verified: json['verified'] ?? false,
    );
  }
}
