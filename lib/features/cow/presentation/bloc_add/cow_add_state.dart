part of 'cow_add_bloc.dart';

abstract class CowAddState extends Equatable {
  CowAddState([List props = const <dynamic>[]]) : super(props);
}

class Insert extends CowAddState {}

class Loading extends CowAddState {}

class Loaded extends CowAddState {
  final Cow cow;

  Loaded({@required this.cow}) : super([cow]);
}

class Error extends CowAddState {
  final String message;

  Error({@required this.message}) : super([message]);
}
