import 'package:dartz/dartz.dart';
import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../../entities/user_entity.dart';
import '../../repositories/user_repository.dart';

class GetUserInfosUseCase extends UseCase <Either<String,UserEntity>,dynamic> {
  @override
  Future<Either<String, UserEntity>> call({p}) async => await sl<UserRepository>().getUserInfos();

}