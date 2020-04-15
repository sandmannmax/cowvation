import 'package:chopper/chopper.dart';

part 'cow_api_service.chopper.dart';

@ChopperApi(baseUrl: '/v2/kuh')
abstract class CowApiService extends ChopperService {
  @Get(path: '/')
  Future<Response> getCow(@Header('Authorization') String token, @Query('bnummer') int agrop, @Query('nummer') int cow);

  static CowApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://cvapi.xandmedia.de',
      services: [
        _$CowApiService(),
      ],
      converter: JsonConverter(),
      interceptors: [
        //HttpLoggingInterceptor(),
      ]
    );
    return _$CowApiService(client);
  }
}
