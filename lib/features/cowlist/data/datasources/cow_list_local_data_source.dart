import 'dart:convert';

import 'package:cowvation/core/error/exceptions.dart';
import 'package:cowvation/core/token/data/models/token_model.dart';
import 'package:cowvation/features/cowlist/data/models/cow_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

abstract class CowListLocalDataSource {
  /// Gets the cached [CowModel].
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<CowModel>> getCowList(int agrop);

  Future<void> cacheCowList(List<CowModel> cowListToCache, int agrop);
}

const CACHED_COW_LIST = 'CACHED_COW_LIST_';
class CowListLocalDataSourceImpl implements CowListLocalDataSource {
  final SharedPreferences sharedPreferences;

  CowListLocalDataSourceImpl({ @required this.sharedPreferences });

  @override
  Future<List<CowModel>> getCowList(int agrop) {
    final jsonString = sharedPreferences.getString(CACHED_COW_LIST + agrop.toString());
     if (jsonString != null) {
      List<dynamic> list = json.decode(jsonString)['cowlist'];
      List<CowModel> cowList = List<CowModel>();
      for (dynamic json in list) {
        cowList.add(CowModel.fromJson(json));
      }  
      return Future.value(cowList);
     } else {
       throw CacheException();
     }
  }

  @override
  Future<void> cacheCowList(List<CowModel> cowListToCache, int agrop) {
    String jsonCowList = '{"cowlist":[';
    cowListToCache.forEach((cow) {
      jsonCowList = jsonCowList + json.encode(cow.toJson()) + ',';
    });    
    jsonCowList = jsonCowList.substring(0, jsonCowList.length-1) + ']}';
    return sharedPreferences.setString(
      CACHED_COW_LIST + agrop.toString(),
      jsonCowList
    );
  }
}
  
