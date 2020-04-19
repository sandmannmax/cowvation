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

  @override
  Future<Response<dynamic>> changeCow(
      {String token,
      int number,
      int numberEar,
      String race,
      String colorTendency,
      String height,
      bool fetch,
      bool manual,
      String group,
      int agrop,
      http.MultipartFile imageOne,
      http.MultipartFile imageTwo,
      http.MultipartFile imageThree}) {
    final $url = '/v2/kuh/';
    final $headers = {'Authorization': token};
    final $parts = <PartValue>[
      PartValue<int>('number', number),
      PartValue<int>('number_ear', numberEar),
      PartValue<String>('race', race),
      PartValue<String>('color_tendency', colorTendency),
      PartValue<String>('height', height),
      PartValue<bool>('fetch', fetch),
      PartValue<bool>('manual', manual),
      PartValue<String>('group', group),
      PartValue<int>('agrop', agrop),
      PartValue<http.MultipartFile>('image_one', imageOne),
      PartValue<http.MultipartFile>('image_two', imageTwo),
      PartValue<http.MultipartFile>('image_three', imageThree)
    ];
    final $request = Request('POST', $url, client.baseUrl,
        parts: $parts, multipart: true, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addCow(
      {String token,
      int number,
      int numberEar,
      String race,
      String colorTendency,
      String height,
      bool fetch,
      bool manual,
      String group,
      int agrop,
      http.MultipartFile imageOne,
      http.MultipartFile imageTwo,
      http.MultipartFile imageThree}) {
    final $url = '/v2/kuh/hinzufuegen/';
    final $headers = {'Authorization': token};
    final $parts = <PartValue>[
      PartValue<int>('number', number),
      PartValue<int>('number_ear', numberEar),
      PartValue<String>('race', race),
      PartValue<String>('color_tendency', colorTendency),
      PartValue<String>('height', height),
      PartValue<bool>('fetch', fetch),
      PartValue<bool>('manual', manual),
      PartValue<String>('group', group),
      PartValue<int>('agrop', agrop),
      PartValue<http.MultipartFile>('image_one', imageOne),
      PartValue<http.MultipartFile>('image_two', imageTwo),
      PartValue<http.MultipartFile>('image_three', imageThree)
    ];
    final $request = Request('POST', $url, client.baseUrl,
        parts: $parts, multipart: true, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}
