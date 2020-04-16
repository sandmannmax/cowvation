import 'package:cowvation/core/error/failures.dart';
import 'package:cowvation/core/token/domain/entities/token.dart';
import 'package:cowvation/core/token/domain/repositories/token_repository.dart';
import 'package:cowvation/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetTokenLogin implements UseCase<Token, Params>{
  final TokenRepository repository;

  GetTokenLogin(this.repository);

  @override
  Future<Either<Failure, Token>> call(Params params) async {
    return await repository.getTokenLogin(params.username, params.password);
  }
}

class Params extends Equatable {
  final String username;
  final String password;

  Params({@required this.username, @required this.password}) : super([username, password]);
}