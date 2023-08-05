import 'package:pokedex/core/http_client/domain/http_client_exception.dart';

typedef SerializeToJson<T> = Map<String, dynamic> Function(T obj);
typedef DeserializeFromJson<T> = T Function(Map<String, dynamic> json);

abstract class IHttpClient {
  Future<(T?, AppException?)> get<T extends Object>({
    required String endpoint,
    required DeserializeFromJson<T> deserializeResponseFunction,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic> payload,
    DeserializeFromJson<AppException>? customErrorDeserializer,
  });

  Future<(List<T>?, AppException?)> getList<T extends Object>({
    required String endpoint,
    required DeserializeFromJson<T> deserializeResponseFunction,
    Map<String, dynamic>? queryParams,
    DeserializeFromJson<AppException>? customErrorDeserializer,
  });

  Future<(T?, AppException?)> post<T extends Object>({
    required String endpoint,
    required Map<String, dynamic> payload,
    required DeserializeFromJson<T> deserializeResponseFunction,
    Map<String, dynamic>? queryParams,
    DeserializeFromJson<AppException>? customErrorDeserializer,
  });

  Future<(T?, AppException?)> put<T extends Object>({
    required String endpoint,
    required Map<String, dynamic> payload,
    required DeserializeFromJson<T> deserializeResponseFunction,
    DeserializeFromJson<AppException>? customErrorDeserializer,
  });

  Future<AppException?> delete({
    required String endpoint,
    DeserializeFromJson<AppException>? customErrorDeserializer,
  });
}
