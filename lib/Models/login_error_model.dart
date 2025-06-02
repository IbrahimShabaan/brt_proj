class ErrorDetail {
  final String errorAr;
  final String errorEn;
  final String? hintAr;
  final String? hintEn;

  ErrorDetail({
    required this.errorAr,
    required this.errorEn,
    this.hintAr,
    this.hintEn,
  });

  factory ErrorDetail.fromJson(Map<String, dynamic> json) {
    return ErrorDetail(
      errorAr: json['errorAr'],
      errorEn: json['errorEn'],
      hintAr: json['hintAr'],
      hintEn: json['hintEn'],
    );
  }
}

class ErrorResponse {
  final bool isValid;
  final List<ErrorDetail> errors;

  ErrorResponse({
    required this.isValid,
    required this.errors,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      isValid: json['isValid'],
      errors: (json['errors'] as List)
          .map((e) => ErrorDetail.fromJson(e))
          .toList(),
    );
  }
}

class LoginResponse {
  final dynamic data;
  final ErrorResponse? error;
  final bool isSuccess;

  LoginResponse({
    this.data,
    this.error,
    required this.isSuccess,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      data: json['data'],
      error: json['error'] != null ? ErrorResponse.fromJson(json['error']) : null,
      isSuccess: json['isSuccess'],
    );
  }
}