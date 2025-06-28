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

//create child account setup states
final class ChildAccountSetupLoadingState extends AuthStates {}

final class ChildAccountSetupSuccessState extends AuthStates {}

final class ChildAccountSetupErrorState extends AuthStates {
  final String message;
  ChildAccountSetupErrorState({required this.message});
}

//create add parent data states
final class AddParentDataLoadingState extends AuthStates {}

final class AddParentDataSuccessState extends AuthStates {}

final class AddParentDataErrorState extends AuthStates {
  final String message;
  AddParentDataErrorState({required this.message});
}

//create add child data states
final class AddChildDataLoadingState extends AuthStates {}

final class AddChildDataSuccessState extends AuthStates {}

final class AddChildDataErrorState extends AuthStates {
  final String message;
  AddChildDataErrorState({required this.message});
}
