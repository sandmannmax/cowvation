import 'package:cowvation/core/error/failures.dart';
import 'package:cowvation/features/cow/domain/entities/cow.dart';
import 'package:cowvation/features/cow/domain/usecases/get_cow.dart' as gc;
import 'package:cowvation/features/cow/domain/usecases/change_cow.dart' as cc;
import 'package:cowvation/features/cow/domain/usecases/add_cow.dart' as ac;
import 'package:dartz/dartz.dart';

abstract class CowRepository {
  Future<Either<Failure, Cow>> getCow(gc.Params params);
  Future<Either<Failure, Cow>> changeCow(cc.Params params);
  Future<Either<Failure, Cow>> addCow(ac.Params params);
}