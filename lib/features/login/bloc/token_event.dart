part of 'token_bloc.dart';

@immutable
abstract class TokenEvent extends Equatable {
  TokenEvent([List props = const <dynamic>[]]) : super(props);
}

class GetTokenE extends TokenEvent {
  final String username;
  final String password;

  GetTokenE(this.username, this.password) : super([username, password]);
}
