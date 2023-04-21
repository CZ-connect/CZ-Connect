class Referral {
  int id;
  String status;
  String participantName;
  String? participantEmail;
  String? participantPhoneNumber;
  DateTime registrationDate;

  Referral(
      {required this.id,
      required this.status,
      required this.participantName,
      this.participantEmail,
      this.participantPhoneNumber,
      required this.registrationDate});

  factory Referral.fromJson(Map<String, dynamic> json) {
    return Referral(
      id: json['id'],
      participantName: json['participantName'],
      participantEmail: json['participantEmail'],
      participantPhoneNumber: json['participantPhoneNumber'],
      status: json['status'],
      registrationDate: DateTime.parse(json['registrationDate']),
    );
  }
}
