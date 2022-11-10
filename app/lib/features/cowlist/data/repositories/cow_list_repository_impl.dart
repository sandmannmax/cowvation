import 'package:cowvation/core/error/exceptions.dart';
import 'package:cowvation/core/error/failures.dart';
import 'package:cowvation/core/network/network_info.dart';
import 'package:cowvation/core/token/domain/repositories/token_repository.dart';
import 'package:cowvation/features/cowlist/data/datasources/cow_list_local_data_source.dart';
import 'package:cowvation/features/cowlist/data/datasources/cow_list_remote_data_source.dart';
import 'package:cowvation/features/cowlist/domain/entities/cow.dart';
import 'package:cowvation/features/cowlist/domain/repositories/cow_list_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class CowListRepositoryImpl implements CowListRepository {
  final CowListRemoteDataSource remoteDataSource;
  final CowListLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final TokenRepository tokenRepository;

  CowListRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
    @required this.tokenRepository,
  });

  @override
  Future<Either<Failure, List<Cow>>> getCowList() async {
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
        final remoteCowList = await remoteDataSource.getCowList(token, agrop);
        localDataSource.cacheCowList(remoteCowList, agrop);
        return Right(remoteCowList);
      } on ServerException {
        return Left(ServerFailure());
      } on ForbiddenException {
        return Left(ForbiddenFailure());
      }  
    } else {
      try {
        final localCowList = await localDataSource.getCowList(agrop);
        return Right(localCowList);
      } on CacheException {
        return Left(CacheFailure());
      }      
    }      
  }
}
