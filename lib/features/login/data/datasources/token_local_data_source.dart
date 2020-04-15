import 'dart:convert';

import 'package:cowvation/core/error/exceptions.dart';
import 'package:cowvation/features/login/data/models/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

abstract class TokenLocalDataSource {
  /// Gets the cached [TokenModel].
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<TokenModel> getToken();

  Future<void> cacheToken(TokenModel tokenToCache);
}

const CACHED_TOKEN = 'CACHED_TOKEN';

class TokenLocalDataSourceImpl implements TokenLocalDataSource {
  final SharedPreferences sharedPreferences;

  TokenLocalDataSourceImpl({ @required this.sharedPreferences });

  @override
  Future<TokenModel> getToken() {
     final jsonString = sharedPreferences.getString(CACHED_TOKEN);
     if (jsonString != null) {
      return Future.value(TokenModel.fromJson(json.decode(jsonString)));
     } else {
       throw CacheException();
     }
  }

  @override
  Future<void> cacheToken(TokenModel tokenToCache) {
    return sharedPreferences.setString(
      CACHED_TOKEN,
      json.encode(tokenToCache.toJson())
    );
  }
}
  
