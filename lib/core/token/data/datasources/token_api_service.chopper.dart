// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$TokenApiService extends TokenApiService {
  _$TokenApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = TokenApiService;

  @override
  Future<Response<dynamic>> getToken(Map<String, dynamic> body) {
    final $url = '/v2/token/';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> refreshToken(Map<String, dynamic> body) {
    final $url = '/v2/token/refresh/';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
