import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/usecase/usecase.dart';
import 'button_state.dart';


class ButtonStateCubit extends Cubit<ButtonState>{
  ButtonStateCubit(): super(ButtonInitialState());

  void execute({dynamic params, required UseCase useCase}) async{
    emit(ButtonLoadingState());
    Either result = await useCase.call(p: params);
    result.fold(
        (error){
          emit(ButtonFailureState(errorMsg: error));
        },
        (data){
          emit(ButtonSuccessState());
        }
    );
  }
}