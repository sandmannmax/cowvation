import 'package:cowvation/core/error/failures.dart';
import 'package:cowvation/core/usecases/usecase.dart';
import 'package:cowvation/features/cow/domain/entities/cow.dart';
import 'package:cowvation/features/cow/domain/repositories/cow_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class ChangeCow implements UseCase<Cow, Params> {
  final CowRepository repository;

  ChangeCow(this.repository);

  @override
  Future<Either<Failure, Cow>> call(Params params) async {
    return await repository.changeCow(params);
  }
}

class Params extends Equatable {
  final int cowNumber;
  final int numberEar;
  final String race;
  final String colorTendency;
  final String height;
  final bool fetch;
  final bool manual;
  final String group;
  final MultipartFile imageOne; 
  final MultipartFile imageTwo; 
  final MultipartFile imageThree; 

  Params({
    @required this.cowNumber,
    @required this.numberEar,
    @required this.race,
    @required this.colorTendency,
    @required this.height,
    @required this.fetch,
    @required this.manual,
    @required this.group,
    this.imageOne,
    this.imageTwo,
    this.imageThree,
  }) : super([
    cowNumber,
    numberEar,
    race,
    colorTendency,
    height,
    fetch,
    manual,
    group,
    imageOne,
    imageTwo,
    imageThree,
  ]);
}
