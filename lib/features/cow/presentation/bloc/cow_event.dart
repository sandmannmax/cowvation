part of 'cow_bloc.dart';

abstract class CowEvent extends Equatable {
  CowEvent([List props = const <dynamic>[]]) : super(props);
}

class GetCowE extends CowEvent {
  final int cowNumber;

  GetCowE(this.cowNumber) : super([cowNumber]);
}

class LoadImagesE extends CowEvent {
  final Cow cow;

  LoadImagesE(this.cow) : super([cow]);
}
