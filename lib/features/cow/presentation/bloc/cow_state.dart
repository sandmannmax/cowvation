part of 'cow_bloc.dart';


abstract class CowState extends Equatable {
  CowState([List props = const <dynamic>[]]) : super(props);
}

class Loading extends CowState {}

class Loaded extends CowState {
  final Cow cow;

  Loaded({ @required this.cow }) : super([cow]);
}

class Error extends CowState {
  final String message;

  Error({ @required this.message }) : super([message]);
}