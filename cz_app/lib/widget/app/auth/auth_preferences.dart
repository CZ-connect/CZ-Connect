import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserPreferences {
  static SharedPreferences? _prefs;
  static const _keyToken = 'token';
  static const _keyUserId = 'userId';
  static const _keyUserName = 'userName';
  static const _keyUserRole = 'userRole';
  static const _keyIsLoggedIn = 'isLoggedIn';

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future setUserFromToken(String token) async {
    // decode the JWT token to extract user information
    // here we assume the token payload contains the following fields: userId, userName, userEmail
    Map<String, dynamic> decodedToken = decodeJWT(token);
      // save the user information in SharedPreferences
    await _prefs?.setString(_keyToken, token);
    await _prefs?.setString(_keyUserId, decodedToken['id']);
    await _prefs?.setString(_keyUserName, decodedToken['displayname']);
    await _prefs?.setString(_keyUserRole, decodedToken['role']);
    await _prefs?.setBool(_keyIsLoggedIn, true);
  }

  static String checkSavedToken() {
    String token = _prefs?.getString(_keyToken) ?? '';
    checkToken(token); // check if the token is still valid
    return token;
  }

  static String getUserId() {
    checkSavedToken();
    return _prefs?.getString(_keyUserId) ?? '';
  }

  static String getUserName() {
    checkSavedToken();
    return _prefs?.getString(_keyUserName) ?? '';
  }

  static String getUserRole() {
    checkSavedToken();
    return _prefs?.getString(_keyUserRole) ?? '';
  }

  static bool isLoggedIn() {
    checkSavedToken();
    return _prefs?.getBool(_keyIsLoggedIn) ?? false;
  }

  static Future logOut() async {
    if (_prefs != null ) {
      await _prefs!.remove(_keyToken);
      await _prefs!.remove(_keyUserId);
      await _prefs!.remove(_keyUserName);
      await _prefs!.remove(_keyUserRole);
      await _prefs!.setBool(_keyIsLoggedIn, false);
    }
  }

  static void checkToken(String token) {
    if (token.isNotEmpty && Jwt.isExpired(token)) {
      // token is expired, log out the user
      logOut();
    }
  }

  static Map<String, dynamic> decodeJWT(String token) {
    return JwtDecoder.decode(token);
  }
}
