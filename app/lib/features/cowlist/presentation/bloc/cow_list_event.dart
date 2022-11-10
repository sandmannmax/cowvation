part of 'cow_list_bloc.dart';

@immutable
abstract class CowListEvent extends Equatable {
  CowListEvent([List props = const <dynamic>[]]) : super(props);
}

class GetCowListE extends CowListEvent {
  GetCowListE() : super();
}