
import '../../../domain/entities/user_entity.dart';

abstract class UserInfosState {}

class UserInfosInitialState extends UserInfosState {}
class UserInfosLoadingState extends UserInfosState {}

class UserInfosFailureState extends UserInfosState {
  final String errorMsg;
  UserInfosFailureState({required this.errorMsg});
}

class UserInfosSuccessState extends UserInfosState {
  final UserEntity user;
  UserInfosSuccessState({required this.user});
}