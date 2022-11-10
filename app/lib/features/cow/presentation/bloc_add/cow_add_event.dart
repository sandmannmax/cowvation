part of 'cow_add_bloc.dart';

abstract class CowAddEvent extends Equatable {
  CowAddEvent([List props = const <dynamic>[]]) : super(props);
}

class CowAddE extends CowAddEvent {
  final int cowNumber;
  final int numberEar;
  final String race;
  final String colorTendency;
  final String height;
  final bool fetch;
  final bool manual;
  final String group;
  final String imageOne; 
  final String imageTwo; 
  final String imageThree; 

  CowAddE({
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