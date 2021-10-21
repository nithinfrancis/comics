///use this class for handling application error
class AppError {
  final int errorCode;
  final String message;
  final String? key;

  static AppError noInternet = AppError(errorCode: AppErrorCodes.noInterNet, message: "Please check your internet connection and try again.");
  static AppError internalError = AppError(errorCode: AppErrorCodes.internalError, message: "Something went wrong please try again later.");
  static AppError unAuthorizedAccess = AppError(errorCode: AppErrorCodes.unAuthorizedAccess, message: "Something went wrong please re login again.");

  AppError({required this.errorCode, required this.message, this.key});

  String get getMessage => message;

  int get getErrorCode => errorCode;

  @override
  String toString() {
    return 'AppError{code: $errorCode, message: $message}';
  }

  factory AppError.fromJson(Map<String, dynamic> json, int errorCode) {
    return AppError(
      errorCode: json['code'] ?? 404,
      key: json['error'] ?? "",
      message: json['error_description'] ?? "Something went wrong Please try again.",
    );
  }
}

class AppErrorCodes {
  static const int noInterNet = 101;
  static const int serverError = 102;
  static const int internalError = 103;
  static const int unAuthorizedAccess = 104;
}
