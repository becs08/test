import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obi/data/models/auth/login_request.dart';
import 'package:obi/domain/usecases/auth/login_usecase.dart';

import '../../../domain/usecases/auth/is_logged_in_usecase.dart';
import '../../../domain/usecases/auth/logout_usecase.dart';
import '../../../service_locator.dart';
import 'auth_state.dart';

class AuthStateCubit extends Cubit<AuthState>{
  AuthStateCubit(): super(AppInitialState());

  void appStarted() async{
    bool isLoggedIn = await sl<IsLoggedInUseCase>().call();
    if(isLoggedIn){
      emit(AuthenticatedState());
    } else{
      emit(UnAuthenticatedState());
    }
  }

  Future logout() async{
    await sl<LogoutUseCase>().call();
    emit(UnAuthenticatedState());
  }


  Future login(LoginRequest r) async {
    emit(AuthenticatedState());
    /*
    emit(TryToAuthenticateState());
    var res = await sl<LoginUseCase>().call(p: r);
    res.fold(
        (error){
          emit(FailToAuthenticateState(message: error));
        },
        (data){
          emit(AuthenticatedState());
        }
    );
     */

  }
}