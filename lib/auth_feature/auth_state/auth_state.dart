abstract class AuthState {}

class AuthInitial extends AuthState {
  final String phone;
  final String password;
  final String confirmPassword;
  final bool obscurePassword;
  final bool obscureConfirmPassword;

  AuthInitial({
    this.phone = '',
    this.password = '',
    this.confirmPassword = '',
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
  });

  AuthInitial copyWith({
    String? phone,
    String? password,
    String? confirmPassword,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
  }) {
    return AuthInitial(
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
    );
  }
}

class SignupLoading extends AuthState {}

class SignupSuccess extends AuthState {}

class SignupFailure extends AuthState {
  final String error;
  SignupFailure(this.error);
}

// auth_state.dart
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {}
class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}