part of 'token_bloc.dart';

@immutable
abstract class TokenState extends Equatable {
  TokenState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends TokenState {}

class Loading extends TokenState {}

class Loaded extends TokenState {
  final Token token;

  Loaded({@required this.token}) : super([token]);
}

class Error extends TokenState {
  final String message;

  Error({@required this.message}) : super([message]);
}
