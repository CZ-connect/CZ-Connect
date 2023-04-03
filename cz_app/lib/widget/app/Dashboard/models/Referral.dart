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
      participantName: json['participantName'],
      participantEmail: json['participantEmail'],
      status: json['status'],
      registrationDate: DateTime.parse(json['registrationDate']),
    );
  }
}
