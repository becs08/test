import 'package:obi/core/constants/key_names.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/constants/api_response_status_codes.dart';
import '../../core/constants/api_urls.dart';
import '../../core/network/dio_client.dart';
import '../../service_locator.dart';
import '../models/auth/login_request.dart';
import '../models/auth/login_response.dart';
import '../models/auth/register_request.dart';

abstract class AuthApiService {
  Future<Either<String,LoginResponse>> login(LoginRequest request);
  Future<Either> register(RegisterRequest request);
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either<String,LoginResponse>> login(LoginRequest request) async {
    try {
      var json = (await  sl<DioClient>().post(ApiUrls.login, data: request.toJson())).data;
      return Right(LoginResponse.fromJson(json[KeyNames.payload]));

    } on DioException catch (e)  {
      return Left('${e.message}');
    }
  }

  @override
  Future<Either> register(RegisterRequest request) {
    try {
      sl<DioClient>().post(ApiUrls.register);
    } catch (e) {

    }
    throw UnimplementedError();
  }
}
