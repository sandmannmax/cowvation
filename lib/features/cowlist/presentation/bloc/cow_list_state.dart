part of 'cow_list_bloc.dart';

@immutable
abstract class CowListState extends Equatable {
  CowListState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends CowListState {}

class Loading extends CowListState {}

class Loaded extends CowListState {
  final List<Cow> cowList;

  Loaded({ @required this.cowList }) : super([cowList]);
}

class Error extends CowListState {
  final String message;

  Error({ @required this.message }) : super([message]);
}
