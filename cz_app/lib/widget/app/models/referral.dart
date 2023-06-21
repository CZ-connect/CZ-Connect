import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Referral {
  int id;
  String status;
  String participantName;
  String? participantEmail;
  String? participantPhoneNumber;
  DateTime registrationDate;
  int? employeeId;
  String? linkedin;

  Referral(
      {required this.id,
      required this.status,
      required this.participantName,
      this.participantEmail,
      this.participantPhoneNumber,
      required this.linkedin,
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
      linkedin: json['linkedin'] ?? "-",
    );
  }

  String translateStatus(BuildContext context) {
    switch (status) {
      case "Approved":
        return AppLocalizations.of(context)!.approved;
      case "Denied":
        return AppLocalizations.of(context)!.denied;
      case "Pending":
        return AppLocalizations.of(context)!.pending;
      default:
        return ""; // Fallback value when the status doesn't match any cases
    }
  }
}
