import 'package:cowvation/core/error/failures.dart';
import 'package:cowvation/core/token/domain/entities/token.dart';
import 'package:cowvation/core/token/domain/repositories/token_repository.dart';
import 'package:cowvation/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetToken implements UseCase<Token, void>{
  final TokenRepository repository;

  GetToken(this.repository);

  @override
  Future<Either<Failure, Token>> call(void v) async {
    return await repository.getToken();
  }
}