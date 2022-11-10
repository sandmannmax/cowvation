import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cowvation/core/error/failures.dart';
import 'package:cowvation/features/cowlist/domain/entities/cow.dart';
import 'package:cowvation/features/cowlist/domain/usecases/get_cow_list.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'cow_list_event.dart';
part 'cow_list_state.dart';

const String SERVER_FAILURE_MESSAGE = "Server Failure";
const String FORBIDDEN_FAILURE_MESSAGE = "Token Validation Error";
const String CACHE_FAILURE_MESSAGE = "Cache Failure";

class CowListBloc extends Bloc<CowListEvent, CowListState> {
  final GetCowList getCowList;

  CowListBloc({
    @required this.getCowList,
  }) : assert(getCowList != null);

  @override
  CowListState get initialState => Loading();

  @override
  Stream<CowListState> mapEventToState(
    CowListEvent event,
  ) async* {
    if (event is GetCowListE) {
      yield Loading();
      void v;
      final failureOrCowList = await getCowList(v);      
      yield failureOrCowList.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (cowList) {
          cowList.sort((a, b) {
            return a.number.toString().compareTo(b.number.toString());
          });
          return Loaded(cowList: cowList);
        }
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
