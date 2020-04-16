import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cowvation/core/error/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:cowvation/features/cow/domain/entities/cow.dart';
import 'package:cowvation/features/cow/domain/usecases/get_cow.dart';

part 'cow_event.dart';
part 'cow_state.dart';

const String SERVER_FAILURE_MESSAGE = "Server Failure";
const String FORBIDDEN_FAILURE_MESSAGE = "Token Validation Error";
const String CACHE_FAILURE_MESSAGE = "Cache Failure";

class CowBloc extends Bloc<CowEvent, CowState> {
  final GetCow getCow;

  CowBloc({
    @required this.getCow,
  }) : assert(getCow != null);

  @override
  CowState get initialState => Loading();

  @override
  Stream<CowState> mapEventToState(
    CowEvent event,
  ) async* {
    if (event is GetCowE) {
      yield Loading();
      final failureOrCowList = await getCow(Params(cowNumber: event.cowNumber));      
      yield failureOrCowList.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (cow) => Loaded(cow: cow)
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
