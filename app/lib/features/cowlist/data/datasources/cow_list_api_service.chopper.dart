// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cow_list_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$CowListApiService extends CowListApiService {
  _$CowListApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = CowListApiService;

  @override
  Future<Response<dynamic>> getCowList(String token, int agrop) {
    final $url = '/v2/kuh/';
    final $params = <String, dynamic>{'bnummer': agrop};
    final $headers = {'Authorization': token};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}
