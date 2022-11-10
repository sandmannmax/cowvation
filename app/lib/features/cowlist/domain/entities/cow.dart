import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Cow extends Equatable {
  final int number;
  final int numberEar;
  final String race;
  final int agrop;

  Cow({
    @required this.number,
    @required this.numberEar,
    @required this.race,
    @required this.agrop,
  }) : super([number, numberEar, race, agrop]);
}