import 'package:cowvation/core/error/failures.dart';
import 'package:cowvation/core/usecases/usecase.dart';
import 'package:cowvation/features/cowlist/domain/entities/cow.dart';
import 'package:cowvation/features/cowlist/domain/repositories/cow_list_repository.dart';
import 'package:dartz/dartz.dart';

class GetCowList implements UseCase<List<Cow>, void>{
  final CowListRepository repository;

  GetCowList(this.repository);

  @override
  Future<Either<Failure, List<Cow>>> call(void v) async {
    return await repository.getCowList();
  }
}