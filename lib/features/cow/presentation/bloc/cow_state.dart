part of 'cow_bloc.dart';

abstract class CowState extends Equatable {
  CowState([List props = const <dynamic>[]]) : super(props);
}

class Loading extends CowState {}

class Loaded extends CowState {
  final Cow cow;

  Loaded({@required this.cow}) : super([cow]);
}

class LoadedImages extends CowState {
  final Cow cow;
  final List<File> imageFiles;

  LoadedImages({
    @required this.cow,
    @required this.imageFiles,
  }) : super([cow, imageFiles]);
}

class Error extends CowState {
  final String message;

  Error({@required this.message}) : super([message]);
}

class Insert extends CowState {}
