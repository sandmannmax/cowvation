import 'package:cowvation/core/error/exceptions.dart';
import 'package:cowvation/core/error/failures.dart';
import 'package:cowvation/core/network/network_info.dart';
import 'package:cowvation/core/token/data/datasources/token_local_data_source.dart';
import 'package:cowvation/core/token/data/datasources/token_remote_data_source.dart';
import 'package:cowvation/core/token/data/models/token_model.dart';
import 'package:cowvation/core/token/domain/entities/token.dart';
import 'package:cowvation/core/token/domain/repositories/token_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class TokenRepositoryImpl implements TokenRepository {
  final TokenRemoteDataSource remoteDataSource;
  final TokenLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TokenRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Token>> getTokenLogin(
    String username, 
    String password
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteToken = await remoteDataSource.getToken(username, password);
        localDataSource.cacheToken(remoteToken);
        return Right(remoteToken);
      } on ServerException {
        return Left(ServerFailure());
      } on ForbiddenException {
        return Left(ForbiddenFailure());
      }  
    } else {
      return Left(NoNetworkFailure());
    }      
  }

  @override
  Future<Either<Failure, Token>> getToken() async {
    TokenModel token;
    try {
      token = await localDataSource.getToken();
    } on CacheException {
      return Left(CacheFailure());
    }   
    if (DateTime.now().isAfter(token.accessFetch.add(Duration(seconds: 295)))) {
      try {
        final newToken = await remoteDataSource.refreshToken(token.refresh, token.firstFetch);
        localDataSource.cacheToken(newToken);
        return Right(newToken);
      } on ServerException {
        return Left(ServerFailure());
      } on ForbiddenException {
        return Left(ForbiddenFailure());
      }
    } else {
      return Right(token);
    }
  }
}
