import 'package:cowvation/core/error/failures.dart';
import 'package:cowvation/features/cow/domain/entities/cow.dart';
import 'package:cowvation/features/cow/domain/usecases/get_cow.dart';
import 'package:dartz/dartz.dart';

abstract class CowRepository {
  Future<Either<Failure, Cow>> getCow(Params params);
}