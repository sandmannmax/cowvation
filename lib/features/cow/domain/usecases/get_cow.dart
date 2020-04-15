import 'package:cowvation/core/error/failures.dart';
import 'package:cowvation/core/usecases/usecase.dart';
import 'package:cowvation/features/cow/domain/entities/cow.dart';
import 'package:cowvation/features/cow/domain/repositories/cow_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetCow implements UseCase<Cow, Params>{
  final CowRepository repository;

  GetCow(this.repository);

  @override
  Future<Either<Failure, Cow>> call(Params params) async {
    return await repository.getCow(params);
  }
}

class Params extends Equatable {
  final int cowNumber;

  Params({ @required this.cowNumber }) : super([cowNumber]);
}