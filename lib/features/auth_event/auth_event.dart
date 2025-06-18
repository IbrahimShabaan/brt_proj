abstract class AuthEvent {}

class UpdatePhone extends AuthEvent {
  final String phone;
  UpdatePhone(this.phone);
}

class UpdatePassword extends AuthEvent {
  final String password;
  UpdatePassword(this.password);
}

class UpdateConfirmPassword extends AuthEvent {
  final String confirmPassword;
  UpdateConfirmPassword(this.confirmPassword);
}

class TogglePasswordVisibility extends AuthEvent {}

class ToggleConfirmPasswordVisibility extends AuthEvent {}

class SignupSubmitted extends AuthEvent {}

class LoginSubmitted extends AuthEvent {
  final String phoneNumber;
  final String password;

  LoginSubmitted({required this.phoneNumber, required this.password});
}
