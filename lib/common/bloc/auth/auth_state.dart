abstract class AuthState {}

class AppInitialState extends AuthState {}
class TryToAuthenticateState extends AuthState {}
class FailToAuthenticateState extends AuthState {
  String message;
  FailToAuthenticateState({required this.message});
}
class AuthenticatedState extends AuthState {}
class UnAuthenticatedState extends AuthState {}
