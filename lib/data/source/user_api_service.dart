import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/api_response_status_codes.dart';
import '../../core/constants/api_urls.dart';
import '../../core/constants/key_names.dart';
import '../../core/network/dio_client.dart';
import '../../domain/entities/user_entity.dart';
import '../../service_locator.dart';
import '../models/user/user_model.dart';

abstract class UserApiService {
  Future<Either<String,UserEntity>> getUserInfos();
}

class UserApiServiceImpl extends UserApiService {
  @override
  Future<Either<String,User>> getUserInfos() async{
    try{
      var json = (await sl<DioClient>().get(ApiUrls.userInfos )).data;

      User data = User.fromJson(json[KeyNames.payload]);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString(KeyNames.codeProfil,data.profil.code);
      //await FirebaseMessaging.instance.unsubscribeFromTopic(data.profil.code);
      //await FirebaseMessaging.instance.subscribeToTopic(data.profil.code);
      return Right(data);

    }catch(e){
      return Left(e.toString());
    }

  }

}