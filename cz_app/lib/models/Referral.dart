class Referral {
  int id;
  String status;
  String employeeName;
  String participantName;
  String participantEmail;
  DateTime registrationDate;

  Referral(
      {required this.id,
      required this.status,
      required this.employeeName,
      required this.participantName,
      required this.participantEmail,
      required this.registrationDate});

  factory Referral.fromJson(Map<String, dynamic> json) {
    return Referral(
      id: json['id'],
      status: json['status'],
      employeeName: json['employeeName'],
      participantName: json['participantName'],
      participantEmail: json['participantEmail'],
      registrationDate: DateTime.parse(json['registrationDate']),
    );
  }
}
