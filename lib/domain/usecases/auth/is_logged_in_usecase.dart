
import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../../repositories/auth_repository.dart';

class IsLoggedInUseCase extends UseCase<bool,dynamic> {
  @override
  Future<bool> call({dynamic p}) async {
    return await sl<AuthRepository>().isLoggedIn();
  }

}