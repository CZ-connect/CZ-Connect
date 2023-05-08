class Referral {
  int id;
  String status;
  String participantName;
  String? participantEmail;
  String? participantPhoneNumber;
  DateTime registrationDate;
  int? employeeId;

  Referral(
      {required this.id,
      required this.status,
      required this.participantName,
      this.participantEmail,
      this.participantPhoneNumber,
      required this.employeeId,
      required this.registrationDate});

  factory Referral.fromJson(Map<String, dynamic> json) {
    return Referral(
      id: json['id'],
      participantName: json['participantName'],
      participantEmail: json['participantEmail'],
      participantPhoneNumber: json['participantPhoneNumber'],
      status: json['status'],
      employeeId: json['employeeId'],
      registrationDate: DateTime.parse(json['registrationDate']),
    );
  }
}
