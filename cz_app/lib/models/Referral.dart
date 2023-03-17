class Referral {
  int id;
  String status;
  String participantName;
  String participantEmail;
  DateTime registrationDate;

  Referral(
      {required this.id,
      required this.status,
      required this.participantName,
      required this.participantEmail,
      required this.registrationDate});

  factory Referral.fromJson(Map<String, dynamic> json) {
    return Referral(
      id: json['id'],
      status: json['status'],
      participantName: json['participantName'],
      participantEmail: json['participantEmail'],
      registrationDate: DateTime.parse(json['registrationDate']),
    );
  }
}
