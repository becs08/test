class LoginRequest{
  final String login;
  final String password;

  LoginRequest({required this.login, required this.password});

  Map<String,dynamic> toJson(){
    return {
      'login': login,
      'password': password
    };
  }
}