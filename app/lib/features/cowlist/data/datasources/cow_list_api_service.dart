import 'package:chopper/chopper.dart';

part 'cow_list_api_service.chopper.dart';

@ChopperApi(baseUrl: '/v2/kuh')
abstract class CowListApiService extends ChopperService {
  @Get(path: '/')
  Future<Response> getCowList(@Header('Authorization') String token, @Query('bnummer') int agrop);

  static CowListApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://cvapi.xandmedia.de',
      services: [
        _$CowListApiService(),
      ],
      converter: JsonConverter(),
      interceptors: [
        //HttpLoggingInterceptor(),
      ]
    );
    return _$CowListApiService(client);
  }
}
