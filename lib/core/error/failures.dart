import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const<dynamic>[]]) : super(properties);
}

// General Failures
class ServerFailure extends Failure {}

class ForbiddenFailure extends Failure {}

class CacheFailure extends Failure {}

class InvalidInputFailure extends Failure {}