import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obi/presentation/home/bloc/user_infos_state.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/user/get_user_infos_usecase.dart';
import '../../../service_locator.dart';

class UserInfosStateCubit extends Cubit<UserInfosState>{
  UserInfosStateCubit(): super(UserInfosInitialState());

  load() async{
    emit(UserInfosLoadingState());
    try{
      Either<String, UserEntity> result = await sl<GetUserInfosUseCase>().call();
      result.fold(
          (errorMsg){
            emit(UserInfosFailureState(errorMsg: errorMsg));
          },
          (user){
            emit(UserInfosSuccessState(user: user));
          }
      );
    } catch(e){

      emit(UserInfosFailureState(errorMsg: e.toString()));
    }
  }
}