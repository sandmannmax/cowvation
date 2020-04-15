import 'package:cowvation/core/error/exceptions.dart';
import 'package:cowvation/core/error/failures.dart';
import 'package:cowvation/core/network/network_info.dart';
import 'package:cowvation/features/login/data/datasources/token_local_data_source.dart';
import 'package:cowvation/features/login/data/datasources/token_remote_data_source.dart';
import 'package:cowvation/features/login/domain/entities/token.dart';
import 'package:cowvation/features/login/domain/repositories/token_repository.dart';
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
  Future<Either<Failure, Token>> getToken(
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
      try {
        final localToken = await localDataSource.getToken();
        return Right(localToken);
      } on CacheException {
        return Left(CacheFailure());
      }      
    }      
  }
}
