import 'package:dartz/dartz.dart';
import '../../data/models/auth/login_request.dart';
import '../../data/models/auth/login_response.dart';
import '../../data/models/auth/register_request.dart';

abstract class AuthRepository{
  Future<Either<String,LoginResponse>> login(LoginRequest request);
  Future<Either> register(RegisterRequest request);
  Future<bool> isLoggedIn();
  Future<Either> logout();
}