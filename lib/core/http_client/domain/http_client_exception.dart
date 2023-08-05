// ignore_for_file: public_member_api_docs, sort_constructors_first

class AppException {
  AppException({
    required this.message,
    this.code,
  });

  final String message;
  final String? code;

  @override
  String toString() => 'AppException(message: $message, code: $code)';
}
