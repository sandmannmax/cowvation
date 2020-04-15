import 'package:cowvation/core/error/failures.dart';
import 'package:cowvation/features/login/domain/entities/token.dart';
import 'package:dartz/dartz.dart';

abstract class TokenRepository {
  Future<Either<Failure, Token>> getToken(String username, String password);
}