import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Cow extends Equatable {
  final int number;
  final String imageOne;
  final String imageTwo;
  final String imageThree;
  final int numberEar;
  final String race;
  final String colorTendency;
  final String height;
  final bool manual;
  final bool fetch;
  final String group;
  final int agrop;

  Cow({
    @required this.number,
    @required this.imageOne,
    @required this.imageTwo,
    @required this.imageThree,
    @required this.numberEar,
    @required this.race,
    @required this.colorTendency,
    @required this.height,
    @required this.manual,
    @required this.fetch,
    @required this.group,
    @required this.agrop,
  }) : super([number, imageOne, imageTwo, imageThree, numberEar, race, colorTendency, height, manual, fetch, group, agrop]);
}