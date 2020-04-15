import 'package:chopper/chopper.dart';

part 'token_api_service.chopper.dart';

@ChopperApi(baseUrl: '/v2/token')
abstract class TokenApiService extends ChopperService {
  @Post(path: '/')
  Future<Response> getToken(@Body() Map<String, dynamic> body);

  @Post(path: '/refresh/')
  Future<Response> refreshToken(@Body() Map<String, dynamic> body);

  static TokenApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://cvapi.xandmedia.de',
      services: [
        _$TokenApiService(),
      ],
      converter: JsonConverter(),
      interceptors: [
        //HttpLoggingInterceptor(),
      ]
    );
    return _$TokenApiService(client);
  }
}
