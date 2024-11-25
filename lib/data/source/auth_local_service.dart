import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/key_names.dart';

abstract class AuthLocalService{
  Future<bool> isLoggedIn();
  Future<Either> logout();
}

class AuthLocalServiceImpl extends AuthLocalService {
  @override
  Future<bool> isLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(KeyNames.jwt);
    return token != null;
  }

  @override
  Future<Either> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? codeProfil = sharedPreferences.getString(KeyNames.codeProfil);
    if(codeProfil != null) {
      //await FirebaseMessaging.instance.unsubscribeFromTopic(codeProfil);
    }
    sharedPreferences.clear();
    return const Right(true);
  }

}