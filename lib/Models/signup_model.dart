class SignUpRequest {
  final String phoneNumber;
  final String password;
  final String confirmPassword;

  SignUpRequest({
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "phoneNumber": phoneNumber,
      "password": password,
      "confirmPassword": confirmPassword,
    };
  }
}