import 'package:cowvation/core/error/exceptions.dart';
import 'package:cowvation/features/cow/data/datasources/cow_api_service.dart';
import 'package:cowvation/features/cow/data/models/cow_model.dart';
import 'package:meta/meta.dart';

abstract class CowRemoteDataSource {
  /// Calls the https://cvapi.xandmedia.de/v2/kuh/ endpoint
  /// 
  /// Throws a [ServerException] for all error codes
  Future<CowModel> getCow(String token, int agrop, int cowNumber);
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
}