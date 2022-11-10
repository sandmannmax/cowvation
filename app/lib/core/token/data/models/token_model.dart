import 'package:cowvation/core/token/domain/entities/token.dart';
import 'package:meta/meta.dart';

class TokenModel extends Token {
  TokenModel({
    @required String access,
    @required String refresh,
    @required DateTime firstFetch,
    @required DateTime accessFetch
  }) : super(access: access, refresh: refresh, firstFetch: firstFetch, accessFetch: accessFetch);

  factory TokenModel.fromJsonNew(Map<String, dynamic> json) {
    return TokenModel(
      access: json['access'], 
      refresh: json['refresh'],
      firstFetch: DateTime.now(),
      accessFetch: DateTime.now(),
    );
  }

  factory TokenModel.fromJsonRefresh(Map<String, dynamic> json, String refresh, DateTime firstFetch) {
    return TokenModel(
      access: json['access'], 
      refresh: refresh,
      firstFetch: firstFetch,
      accessFetch: DateTime.now(),
    );
  }

  factory TokenModel.fromJsonSaved(Map<String, dynamic> json) {
    return TokenModel(
      access: json['access'], 
      refresh: json['refresh'],
      firstFetch: DateTime.parse(json['firstFetch']),
      accessFetch: DateTime.parse(json['accessFetch']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access': access,
      'refresh': refresh,
      'firstFetch': firstFetch.toString(),
      'accessFetch': accessFetch.toString(),
    };
  }
}