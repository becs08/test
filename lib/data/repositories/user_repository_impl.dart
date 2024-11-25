import 'package:dartz/dartz.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../../service_locator.dart';
import '../source/user_api_service.dart';

class UserRepositoryImpl extends UserRepository {

  @override
  Future<Either<String,UserEntity>> getUserInfos() async{
    return await sl<UserApiService>().getUserInfos();
  }

}