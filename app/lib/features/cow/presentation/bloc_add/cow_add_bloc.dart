import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cowvation/core/error/failures.dart';
import 'package:cowvation/features/cow/domain/usecases/add_cow.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:cowvation/features/cow/domain/entities/cow.dart';

part 'cow_add_event.dart';
part 'cow_add_state.dart';

const String SERVER_FAILURE_MESSAGE = "Server Failure";
const String FORBIDDEN_FAILURE_MESSAGE = "Token Validation Error";
const String CACHE_FAILURE_MESSAGE = "Cache Failure";

class CowAddBloc extends Bloc<CowAddEvent, CowAddState> {
  final AddCow addCow;

  CowAddBloc({
    @required this.addCow,
  }) : assert(addCow != null);

  @override
  CowAddState get initialState => Insert();

  @override
  Stream<CowAddState> mapEventToState(
    CowAddEvent event,
  ) async* {
    if (event is CowAddE) {
      yield Loading();
      final failureOrCow = await addCow(Params(
        cowNumber: event.cowNumber, 
        numberEar: event.numberEar,
        race: event.race,
        colorTendency: event.colorTendency,
        height: event.height,
        fetch: event.fetch,
        manual: event.manual,
        group: event.group,
        imageOne: event.imageOne != null ? await MultipartFile.fromPath('image_one', event.imageOne) : null,
        imageTwo: event.imageTwo != null ? await MultipartFile.fromPath('image_two', event.imageTwo) : null,
        imageThree: event.imageThree != null ? await MultipartFile.fromPath('image_three', event.imageThree) : null,
      ));      
      yield failureOrCow.fold(
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
