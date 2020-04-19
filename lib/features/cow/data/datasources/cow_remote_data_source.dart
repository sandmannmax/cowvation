import 'package:cowvation/core/error/exceptions.dart';
import 'package:cowvation/features/cow/data/datasources/cow_api_service.dart';
import 'package:cowvation/features/cow/data/models/cow_model.dart';
import 'package:cowvation/features/cow/domain/usecases/change_cow.dart' as cc;
import 'package:cowvation/features/cow/domain/usecases/add_cow.dart' as ac;
import 'package:meta/meta.dart';

abstract class CowRemoteDataSource {
  /// Calls the https://cvapi.xandmedia.de/v2/kuh/ endpoint
  /// 
  /// Throws a [ServerException] for all error codes
  Future<CowModel> getCow(String token, int agrop, int cowNumber);

  /// Posts to the https://cvapi.xandmedia.de/v2/kuh/ endpoint
  /// 
  /// Throws a [ServerException] for all error codes
  Future<CowModel> changeCow(String token, cc.Params params, int agrop);

  /// Posts to the https://cvapi.xandmedia.de/v2/kuh/hinzufuegen/ endpoint
  /// 
  /// Throws a [ServerException] for all error codes
  Future<CowModel> addCow(String token, ac.Params params, int agrop);
}

class CowRemoteDataSourceImpl implements CowRemoteDataSource {
  final CowApiService client;

  CowRemoteDataSourceImpl({ @required this.client }); 

  @override
  Future<CowModel> getCow(String token, int agrop, int cowNumber) async {
    final String authToken = 'Bearer ' + token;
    final response = await client.getCow(authToken, agrop, cowNumber);
    if (response.isSuccessful){
      return CowModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      throw ForbiddenException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CowModel> changeCow(String token, cc.Params params, int agrop) async {
    final String authToken = 'Bearer ' + token;
    final response = await client.changeCow(
      token: authToken, 
      number: params.cowNumber,
      numberEar: params.numberEar,
      race: params.race,
      colorTendency: params.colorTendency,
      height: params.height,
      fetch: params.fetch,
      manual: params.manual,
      group: params.group,
      agrop: agrop,
      imageOne: params.imageOne,
      imageTwo: params.imageTwo,
      imageThree: params.imageThree,
    );
    if (response.isSuccessful){
      return CowModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      throw ForbiddenException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CowModel> addCow(String token, ac.Params params, int agrop) async {
    final String authToken = 'Bearer ' + token;
    final response = await client.addCow(
      token: authToken, 
      number: params.cowNumber,
      numberEar: params.numberEar,
      race: params.race,
      colorTendency: params.colorTendency,
      height: params.height,
      fetch: params.fetch,
      manual: params.manual,
      group: params.group,
      agrop: agrop,
      imageOne: params.imageOne,
      imageTwo: params.imageTwo,
      imageThree: params.imageThree,
    );
    if (response.isSuccessful){
      return CowModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      throw ForbiddenException();
    } else {
      throw ServerException();
    }
  }
}