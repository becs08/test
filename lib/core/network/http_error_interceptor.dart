import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../constants/api_response_status_codes.dart';
import '../constants/key_names.dart';

class HttpErrorInterceptor extends Interceptor {
  Logger logger = Logger(
      printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true));

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.i('request ==> ${err.type}');

    if(
      err.type == DioExceptionType.connectionError ||
      err.type == DioExceptionType.connectionTimeout ||
      err.type == DioExceptionType.connectionTimeout ||
      err.type == DioExceptionType.connectionTimeout
    ){
      handler.next(
        DioException(
        requestOptions: err.requestOptions,
        message: 'Vérifier votre connexion internet'
      ));
    }
    else if(err.type == DioExceptionType.unknown){
      handler.next(
        DioException(
            requestOptions: err.requestOptions,
            message: '${err.message}'
        ));
    }
    else {
      handler.next(
        DioException(
            requestOptions: err.requestOptions,
            message: 'Erreur interne'
        ));
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {

    if(response.data[KeyNames.status] != ApiResponseStatusCodes.ok){
      throw DioException(
          requestOptions: response.requestOptions,
          type: DioExceptionType.unknown,
          message: response.data['message']
      );
    }
    handler.next(response);
  }

}