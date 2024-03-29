import 'package:cowvation/core/error/exceptions.dart';
import 'package:cowvation/core/error/failures.dart';
import 'package:cowvation/core/network/network_info.dart';
import 'package:cowvation/core/token/domain/repositories/token_repository.dart';
import 'package:cowvation/features/cow/data/datasources/cow_local_data_source.dart';
import 'package:cowvation/features/cow/data/datasources/cow_remote_data_source.dart';
import 'package:cowvation/features/cow/domain/entities/cow.dart';
import 'package:cowvation/features/cow/domain/repositories/cow_repository.dart';
import 'package:cowvation/features/cow/domain/usecases/get_cow.dart' as gc;
import 'package:cowvation/features/cow/domain/usecases/change_cow.dart' as cc;
import 'package:cowvation/features/cow/domain/usecases/add_cow.dart' as ac;
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class CowRepositoryImpl implements CowRepository {
  final CowRemoteDataSource remoteDataSource;
  final CowLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final TokenRepository tokenRepository;

  CowRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
    @required this.tokenRepository,
  });

  @override
  Future<Either<Failure, Cow>> getCow(gc.Params params) async {
    final failureOrToken = (await tokenRepository.getToken());
    String token;
    failureOrToken.fold(
      (failure) => failure,
      (t) {
        token = t.access;
    });
    int agrop = 1;

    if (await networkInfo.isConnected) {
      try {
        final remoteCow = await remoteDataSource.getCow(token, agrop, params.cowNumber);
        localDataSource.cacheCow(remoteCow, agrop, params.cowNumber);
        return Right(remoteCow);
      } on ServerException {
        return Left(ServerFailure());
      } on ForbiddenException {
        return Left(ForbiddenFailure());
      }  
    } else {
      try {
        final localCow = await localDataSource.getCow(agrop, params.cowNumber);
        return Right(localCow);
      } on CacheException {
        return Left(CacheFailure());
      }      
    }      
  }

  @override
  Future<Either<Failure, Cow>> changeCow(cc.Params params) async {
    final failureOrToken = (await tokenRepository.getToken());
    String token;
    failureOrToken.fold(
      (failure) => failure,
      (t) {
        token = t.access;
    });
    int agrop = 1;

    if (await networkInfo.isConnected) {
      try {
        final changedCow = await remoteDataSource.changeCow(token, params, agrop);
        localDataSource.cacheCow(changedCow, agrop, params.cowNumber);
        return Right(changedCow);
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
  Future<Either<Failure, Cow>> addCow(ac.Params params) async {
    final failureOrToken = (await tokenRepository.getToken());
    String token;
    failureOrToken.fold(
      (failure) => failure,
      (t) {
        token = t.access;
    });
    int agrop = 1;

    if (await networkInfo.isConnected) {
      try {
        final newCow = await remoteDataSource.addCow(token, params, agrop);
        localDataSource.cacheCow(newCow, agrop, params.cowNumber);
        return Right(newCow);
      } on ServerException {
        return Left(ServerFailure());
      } on ForbiddenException {
        return Left(ForbiddenFailure());
      }  
    } else {
      return Left(NoNetworkFailure());
    }      
  }
}
