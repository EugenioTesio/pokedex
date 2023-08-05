import 'dart:convert';
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:pokedex/core/http_client/domain/http_client.dart';
import 'package:pokedex/core/http_client/domain/http_client_exception.dart';

class ApiHttpClient implements IHttpClient {
  late String _scheme;
  late String _authority;
  late String _version;

  // Supported HTTP methods
  static const getMethod = 'GET';
  static const postMethod = 'POST';
  static const deleteMethod = 'DELETE';
  static const putMethod = 'PUT';

  final http.Client httpClient = http.Client();

  Uri _buildEndpoint(String endpoint, Map<String, dynamic>? queryParams) {
    if (_scheme == 'https') {
      return Uri.https(_authority, '$_version$endpoint', queryParams);
    } else if (_scheme == 'http') {
      return Uri.http(_authority, '$_version$endpoint', queryParams);
    } else {
      throw Exception('Unsupported URL scheme');
    }
  }

  Future<Map<String, String>> _buildHeaders() async {
    return {
      'Accept': 'application/json',
    };
  }

  Future<(T?, AppException?)> _request<T extends Object>({
    required String method,
    required String endpoint,
    DeserializeFromJson<T>? deserializeResponseFunction,
    Map<String, dynamic>? payload,
    Map<String, dynamic>? queryParams,
    DeserializeFromJson<AppException>? customErrorDeserializer,
  }) async {
    final headers = await _buildHeaders();
    final uri = _buildEndpoint(endpoint, queryParams);

    http.Response response;
    try {
      switch (method) {
        case getMethod:
          response = await httpClient.get(uri, headers: headers);
          break;
        case postMethod:
          headers['Content-Type'] = 'application/json';
          response = await httpClient.post(
            uri,
            headers: headers,
            body: json.encode(payload),
          );
          break;
        case putMethod:
          headers['Content-Type'] = 'application/json';
          response = await httpClient.put(
            uri,
            headers: headers,
            body: json.encode(payload),
          );
          break;
        case deleteMethod:
          response = await httpClient.delete(
            uri,
            headers: headers,
          );
          break;
        default:
          throw Exception('Unsupported HTTP Method');
      }
    } on http.ClientException catch (e) {
      return (
        null,
        AppException(
          message: e.message,
        )
      );
    }

    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      Map<String, dynamic> data;
      try {
        final responseBody = const Utf8Decoder().convert(response.bodyBytes);
        data = json.decode(responseBody);
      } on Exception catch (e) {
        return (
          null,
          AppException(
            message: e.toString(),
          )
        );
      }

      T? responseObject;
      try {
        responseObject = deserializeResponseFunction != null
            ? deserializeResponseFunction(data)
            : null;
      } catch (e) {
        return (
          null,
          AppException(
            message: e.toString(),
          ),
        );
      }

      return (responseObject, null);
    } else if (response.statusCode == HttpStatus.noContent ||
        response.statusCode == HttpStatus.accepted) {
      // Empty response code.
      return (null, null);
    } else {
      return (
        null,
        AppException(
          message: response.reasonPhrase ?? '',
          code: response.statusCode.toString(),
        )
      );
    }
  }

  @override
  Future<(T?, AppException?)> get<T extends Object>({
    required String endpoint,
    required DeserializeFromJson<T> deserializeResponseFunction,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? payload,
    DeserializeFromJson<AppException>? customErrorDeserializer,
  }) async {
    return _request(
      method: getMethod,
      endpoint: endpoint,
      queryParams: queryParams,
      payload: payload,
      deserializeResponseFunction: deserializeResponseFunction,
      customErrorDeserializer: customErrorDeserializer,
    );
  }

  @override
  Future<(List<T>?, AppException?)> getList<T extends Object>({
    required String endpoint,
    required DeserializeFromJson<T> deserializeResponseFunction,
    Map<String, dynamic>? queryParams,
    DeserializeFromJson<AppException>? customErrorDeserializer,
  }) async {
    final headers = await _buildHeaders();
    final uri = _buildEndpoint(endpoint, queryParams);

    final response = await httpClient.get(uri, headers: headers);

    if (response.statusCode == HttpStatus.ok) {
      try {
        final Iterable iterable =
            json.decode(const Utf8Decoder().convert(response.bodyBytes));
        final listOfT = List<T>.from(
          iterable.map((model) => deserializeResponseFunction(model)),
        );
        return (listOfT, null);
      } on Exception catch (e) {
        return (
          null,
          AppException(
            message: e.toString(),
          )
        );
      }
    } else if (response.statusCode == HttpStatus.noContent) {
      // Empty response code.
      return (null, null);
    } else {
      return (
        null,
        AppException(
          message: response.body,
        )
      );
    }
  }

  @override
  Future<(T?, AppException?)> post<T extends Object>({
    required String endpoint,
    required Map<String, dynamic> payload,
    required DeserializeFromJson<T> deserializeResponseFunction,
    DeserializeFromJson<AppException>? customErrorDeserializer,
    Map<String, dynamic>? queryParams,
  }) {
    return _request(
      method: postMethod,
      endpoint: endpoint,
      payload: payload,
      queryParams: queryParams,
      deserializeResponseFunction: deserializeResponseFunction,
      customErrorDeserializer: customErrorDeserializer,
    );
  }

  @override
  Future<AppException?> delete({
    required String endpoint,
    DeserializeFromJson<AppException>? customErrorDeserializer,
  }) async {
    return (await _request(
      method: deleteMethod,
      endpoint: endpoint,
      customErrorDeserializer: customErrorDeserializer,
    ))
        .$2;
  }

  @override
  Future<(T?, AppException?)> put<T extends Object>({
    required String endpoint,
    required Map<String, dynamic> payload,
    required DeserializeFromJson<T> deserializeResponseFunction,
    DeserializeFromJson<AppException>? customErrorDeserializer,
  }) {
    return _request(
      method: putMethod,
      endpoint: endpoint,
      payload: payload,
      deserializeResponseFunction: deserializeResponseFunction,
      customErrorDeserializer: customErrorDeserializer,
    );
  }
}
