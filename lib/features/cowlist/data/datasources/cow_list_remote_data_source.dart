import 'package:cowvation/core/error/exceptions.dart';
import 'package:cowvation/features/cowlist/data/datasources/cow_list_api_service.dart';
import 'package:cowvation/features/cowlist/data/models/cow_model.dart';
import 'package:meta/meta.dart';

abstract class CowListRemoteDataSource {
  /// Calls the https://cvapi.xandmedia.de/v2/kuh/ endpoint
  /// 
  /// Throws a [ServerException] for all error codes
  Future<List<CowModel>> getCowList(String token, int agrop);
}

class CowListRemoteDataSourceImpl implements CowListRemoteDataSource {
  final CowListApiService client;

  CowListRemoteDataSourceImpl({ @required this.client }); 

  @override
  Future<List<CowModel>> getCowList(String token, int agrop) async {
    final String authToken = 'Bearer ' + token;
    final response = await client.getCowList(authToken, agrop);
    if (response.isSuccessful){
      List<dynamic> list = response.body['cowlist'];
      List<CowModel> cowList = List<CowModel>();
      for (dynamic json in list) {
        cowList.add(CowModel.fromJson(json));
      }
      return cowList;
    } else if (response.statusCode == 401) {
      throw ForbiddenException();
    } else {
      throw ServerException();
    }
  }
}