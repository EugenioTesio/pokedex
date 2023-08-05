import 'package:pokedex/core/http_client/domain/http_client_exception.dart';

typedef SerializeToJson<T> = Map<String, dynamic> Function(T obj);
typedef DeserializeFromJson<T> = T Function(Map<String, dynamic> json);

abstract class IHttpClient {
  Future<(T?, HttpClientException?)> get<T extends Object>({
    required String endpoint,
    required DeserializeFromJson<T> deserializeResponseFunction,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic> payload,
    DeserializeFromJson<HttpClientException>? customErrorDeserializer,
  });

  Future<(List<T>?, HttpClientException?)> getList<T extends Object>({
    required String endpoint,
    required DeserializeFromJson<T> deserializeResponseFunction,
    Map<String, dynamic>? queryParams,
    DeserializeFromJson<HttpClientException>? customErrorDeserializer,
  });

  Future<(T?, HttpClientException?)> post<T extends Object>({
    required String endpoint,
    required Map<String, dynamic> payload,
    required DeserializeFromJson<T> deserializeResponseFunction,
    Map<String, dynamic>? queryParams,
    DeserializeFromJson<HttpClientException>? customErrorDeserializer,
  });

  Future<(T?, HttpClientException?)> put<T extends Object>({
    required String endpoint,
    required Map<String, dynamic> payload,
    required DeserializeFromJson<T> deserializeResponseFunction,
    DeserializeFromJson<HttpClientException>? customErrorDeserializer,
  });

  Future<HttpClientException?> delete({
    required String endpoint,
    DeserializeFromJson<HttpClientException>? customErrorDeserializer,
  });
}
