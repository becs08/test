import 'package:dartz/dartz.dart';
import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../../repositories/auth_repository.dart';

class LogoutUseCase extends UseCase<Either,void> {
  @override
  Future<Either> call({void p}) async {
    return await sl<AuthRepository>().logout();
  }

}