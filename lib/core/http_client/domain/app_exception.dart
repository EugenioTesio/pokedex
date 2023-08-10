// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class AppException extends Equatable {
  const AppException({
    required this.message,
    this.code,
  });

  final String message;
  final String? code;

  @override
  String toString() => 'AppException(message: $message, code: $code)';

  @override
  List<Object?> get props => [
        message,
        code,
      ];
}
