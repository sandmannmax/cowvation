import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cowvation/core/error/failures.dart';
import 'package:cowvation/features/login/domain/entities/token.dart';
import 'package:cowvation/features/login/domain/usecases/get_token.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'token_event.dart';
part 'token_state.dart';

const String SERVER_FAILURE_MESSAGE = "Server Failure";
const String FORBIDDEN_FAILURE_MESSAGE = "Wrong Username or Password";
const String CACHE_FAILURE_MESSAGE = "Cache Failure";

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  final GetToken getToken;

  TokenBloc({
    @required this.getToken,
  }) : assert(getToken != null);

  @override
  TokenState get initialState => Empty();

  @override
  Stream<TokenState> mapEventToState(
    TokenEvent event,
  ) async* {
    if (event is GetTokenE) {
      yield Loading();
      final failureOrToken = await getToken(Params(username: event.username, password: event.password));      
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
      default:
        return "Unexpected Error";
    }
  }
}
