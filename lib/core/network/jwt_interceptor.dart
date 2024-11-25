import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/key_names.dart';

class JwtInterceptor extends Interceptor {
  Logger logger = Logger(
      printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true));

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if(!options.path.contains('auth/')){
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String? jwt = sharedPreferences.getString(KeyNames.jwt);
      options.headers[KeyNames.authorization] = '${KeyNames.bearer} $jwt';
    }

    handler.next(options);
  }

}