import 'package:cowvation/core/error/exceptions.dart';
import 'package:cowvation/features/login/data/datasources/token_api_service.dart';
import 'package:cowvation/features/login/data/models/token_model.dart';
import 'package:meta/meta.dart';

abstract class TokenRemoteDataSource {
  /// Calls the https://cvapi.xandmedia.de/v2/token/ endpoint
  /// 
  /// Throws a [ServerException] for all error codes
  Future<TokenModel> getToken(String username, String password);
}

class TokenRemoteDataSourceImpl implements TokenRemoteDataSource {
  final TokenApiService client;

  TokenRemoteDataSourceImpl({ @required this.client }); 

  @override
  Future<TokenModel> getToken(String username, String password) async {
    Map<String, dynamic> body = Map<String, dynamic>();
    body['username'] = username;
    body['password'] = password;
    final response = await client.getToken(body);
    if (response.isSuccessful){
      return TokenModel.fromJson(response.body); 
    } else if (response.statusCode == 401) {
      throw ForbiddenException();
    } else {
      throw ServerException();
    }
  }
}