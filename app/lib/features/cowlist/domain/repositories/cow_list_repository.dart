import 'package:cowvation/core/error/failures.dart';
import 'package:cowvation/features/cowlist/domain/entities/cow.dart';
import 'package:dartz/dartz.dart';

abstract class CowListRepository {
  Future<Either<Failure, List<Cow>>> getCowList();
}