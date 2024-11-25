
class LoginResponse {
  final String login;
  final String token;
  final String type;

  LoginResponse({
    required this.login,
    required this.token,
    required this.type
  });

  factory LoginResponse.fromJson(Map<String,dynamic> json){
    return LoginResponse(
      login: json['login'],
      token: json['token'],
      type: json['type']
    );
  }
}