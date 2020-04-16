import 'package:cowvation/core/error/failures.dart';
import 'package:cowvation/core/token/domain/entities/token.dart';
import 'package:dartz/dartz.dart';

abstract class TokenRepository {
  Future<Either<Failure, Token>> getTokenLogin(String username, String password);
  Future<Either<Failure, Token>> getToken();
}