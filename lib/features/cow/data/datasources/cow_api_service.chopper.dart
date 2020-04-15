// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cow_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$CowApiService extends CowApiService {
  _$CowApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = CowApiService;

  @override
  Future<Response<dynamic>> getCow(String token, int agrop, int cow) {
    final $url = '/v2/kuh/';
    final $params = <String, dynamic>{'bnummer': agrop, 'nummer': cow};
    final $headers = {'Authorization': token};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}
