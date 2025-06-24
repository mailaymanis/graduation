sealed class AuthStates {}

//create auth initial state
final class AuthInitialState extends AuthStates {}

//create regsiter states
final class RegisterLoadingState extends AuthStates {}

final class RegisterSuccessState extends AuthStates {}

final class RegisterErrorState extends AuthStates {
  final String message;
  RegisterErrorState({required this.message});
}

//create login states
final class LoginLoadingState extends AuthStates {}

final class LoginSuccessState extends AuthStates {}

final class LoginErrorState extends AuthStates {
  final String message;
  LoginErrorState({required this.message});
}
