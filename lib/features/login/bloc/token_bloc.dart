import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cowvation/core/error/failures.dart';
import 'package:cowvation/core/token/domain/entities/token.dart';
import 'package:cowvation/core/token/domain/usecases/get_token_login.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'token_event.dart';
part 'token_state.dart';

const String SERVER_FAILURE_MESSAGE = "Server Failure";
const String FORBIDDEN_FAILURE_MESSAGE = "Wrong Username or Password";
const String CACHE_FAILURE_MESSAGE = "Cache Failure";
const String NO_NETWORK_FAILURE_MESSAGE = "Sie haben keine Internetverbingung.";


class TokenBloc extends Bloc<TokenEvent, TokenState> {
  final GetTokenLogin getTokenLogin;

  TokenBloc({
    @required this.getTokenLogin,
  }) : assert(getTokenLogin != null);

  @override
  TokenState get initialState => Empty();

  @override
  Stream<TokenState> mapEventToState(
    TokenEvent event,
  ) async* {
    if (event is GetTokenE) {
      yield Loading();
      final failureOrToken = await getTokenLogin(Params(username: event.username, password: event.password));      
      yield failureOrToken.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (token) => Loaded(token: token)
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case ForbiddenFailure:
        return FORBIDDEN_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case NoNetworkFailure:
        return NO_NETWORK_FAILURE_MESSAGE;
      default:
        return "Unexpected Error";
    }
  }
}
