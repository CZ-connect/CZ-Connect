class Employee {
  String? name;
  String? email;
  String? role;
  Employee(this.name, this.email, this.role);
  // Factory method to create an Employee object from JSON data
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      json['name'] as String?,
      json['email'] as String?,
      json['role'] as String?,
    );
  }
}
