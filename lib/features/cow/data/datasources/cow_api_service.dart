import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'cow_api_service.chopper.dart';

@ChopperApi(baseUrl: '/v2/kuh')
abstract class CowApiService extends ChopperService {
  @Get(path: '/')
  Future<Response> getCow(@Header('Authorization') String token,
      @Query('bnummer') int agrop, @Query('nummer') int cow);

  @Post(path: '/')
  @Multipart()
  Future<Response> changeCow({
    @required @Header('Authorization') String token,
    @required @Part('number') int number,
    @required @Part('number_ear') int numberEar,
    @required @Part('race') String race,
    @required @Part('color_tendency') String colorTendency,
    @required @Part('height') String height,
    @required @Part('fetch') bool fetch,
    @required @Part('manual') bool manual,
    @required @Part('group') String group,
    @required @Part('agrop') int agrop,
    @Part('image_one') http.MultipartFile imageOne,
    @Part('image_two') http.MultipartFile imageTwo,
    @Part('image_three') http.MultipartFile imageThree,
  });

  @Post(path: '/hinzufuegen/')
  @Multipart()
  Future<Response> addCow({
    @required @Header('Authorization') String token,
    @required @Part('number') int number,
    @required @Part('number_ear') int numberEar,
    @required @Part('race') String race,
    @required @Part('color_tendency') String colorTendency,
    @required @Part('height') String height,
    @required @Part('fetch') bool fetch,
    @required @Part('manual') bool manual,
    @required @Part('group') String group,
    @required @Part('agrop') int agrop,
    @Part('image_one') http.MultipartFile imageOne,
    @Part('image_two') http.MultipartFile imageTwo,
    @Part('image_three') http.MultipartFile imageThree,
  });

  static CowApiService create() {
    final client = ChopperClient(
        baseUrl: 'https://cvapi.xandmedia.de',
        services: [
          _$CowApiService(),
        ],
        converter: JsonConverter(),
        interceptors: [
          //HttpLoggingInterceptor(),
        ]);
    return _$CowApiService(client);
  }
}
