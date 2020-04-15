import 'package:cowvation/features/login/domain/entities/token.dart';
import 'package:meta/meta.dart';

class TokenModel extends Token {
  TokenModel({
    @required String access,
    @required String refresh
  }) : super(access: access, refresh: refresh);

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      access: json['access'], 
      refresh: json['refresh']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access': access,
      'refresh': refresh
    };
  }
}