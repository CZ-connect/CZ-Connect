import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> deleteReferral(BuildContext context, int id) async {
  var host = dotenv.env['API_URL'];
  var route = '/api/referral/$id';
  var url = Uri.http(host!, route);
  if(host.isEmpty) {
    url = Uri.https('flutter-backend.azurewebsites.net', route);
  }

  try {
    var response = await http.delete(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json"
    });

    if (response.statusCode >= 400 && response.statusCode <= 499) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppLocalizations.of(context)?.appErrorPrefix}  ${response.statusCode}')),
      );
      throw Exception('${AppLocalizations.of(context)?.appErrorPrefix}  ${response.statusCode}');
    } else if (response.statusCode >= 500 && response.statusCode <= 599) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppLocalizations.of(context)?.appErrorPrefix}  ${response.statusCode}')),
      );
      throw Exception('${AppLocalizations.of(context)?.appErrorPrefix}  ${response.statusCode}');
    }
  } catch (exception) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${AppLocalizations.of(context)?.appErrorPrefix}  ${exception}')),
    );
  }
}
