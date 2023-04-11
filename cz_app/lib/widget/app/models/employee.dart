class Employee {
  String? name;
  String? email;
  Employee(this.name, this.email);
  // Factory method to create an Employee object from JSON data
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      json['name'] as String?,
      json['email'] as String?,
    );
  }
}
