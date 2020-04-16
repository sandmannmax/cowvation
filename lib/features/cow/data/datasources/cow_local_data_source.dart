import 'dart:convert';

import 'package:cowvation/core/error/exceptions.dart';
import 'package:cowvation/core/token/data/models/token_model.dart';
import 'package:cowvation/features/cow/data/models/cow_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

abstract class CowLocalDataSource {
  /// Gets the cached [CowModel].
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<CowModel> getCow(int agrop, int cowNumber);

  Future<void> cacheCow(CowModel cowToCache, int agrop, int cowNumber);
}

const CACHED_COW = 'CACHED_COW_';
const CACHED_TOKEN = 'CACHED_TOKEN';

class CowLocalDataSourceImpl implements CowLocalDataSource {
  final SharedPreferences sharedPreferences;

  CowLocalDataSourceImpl({ @required this.sharedPreferences });

  @override
  Future<CowModel> getCow(int agrop, int cowNumber) {
    final jsonString = sharedPreferences.getString(CACHED_COW + agrop.toString() + '_' + cowNumber.toString());
    if (jsonString != null) {
      return Future.value(CowModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheCow(CowModel cowToCache, int agrop, int cowNumber) {
    return sharedPreferences.setString(
      CACHED_COW + agrop.toString() + '_' + cowNumber.toString(),
      json.encode(cowToCache.toJson())
    );
  }
}
  
