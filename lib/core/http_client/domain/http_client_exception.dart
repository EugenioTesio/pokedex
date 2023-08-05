enum HttpClientExceptionType {
  notFound,
  unknownServerError,
  networkError,
  badResponse,
}

class HttpClientException {
  HttpClientException({
    required this.apiExceptionType,
    this.message,
  });

  final HttpClientExceptionType apiExceptionType;
  final String? message;

  @override
  String toString() =>
      'HttpClientException(apiExceptionType: $apiExceptionType,'
      ' message: $message)';
}
