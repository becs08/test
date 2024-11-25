import 'package:dartz/dartz.dart';
import '../../../core/usecase/usecase.dart';
import '../../../data/models/auth/login_request.dart';
import '../../../data/models/auth/login_response.dart';
import '../../../service_locator.dart';
import '../../repositories/auth_repository.dart';

class LoginUseCase extends UseCase<Either<String,LoginResponse>,LoginRequest> {
  @override
  Future<Either<String,LoginResponse>> call({LoginRequest? p}) async {
    return await sl<AuthRepository>().login(p!);
  }

}