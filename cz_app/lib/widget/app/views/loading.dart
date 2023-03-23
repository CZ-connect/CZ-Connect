import 'package:flutter/material.dart';
import 'package:cz_app/widget/app/services/referralService.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  void setupReference() async {
    ReferralService instance = ReferralService(userId: 1);
    try {
      await instance.getData();
      Navigator.pushReplacementNamed(context, '/referralOverview',
          arguments: {'referrals': instance.referrals});
    } catch (e) {
      print(e);
      Navigator.pushReplacementNamed(context, '/error',
          arguments: {'message': 'Referrals konden niet worden opgehaald'});
    }
    // ignore: use_build_context_synchronously
  }

  @override
  void initState() {
    super.initState();
    setupReference();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Padding(
            padding: EdgeInsets.all(50.0),
            child: Center(child: Text("Ophalen van gegevens..."))));
  }
}
