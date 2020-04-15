import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Token extends Equatable {
  final String access;
  final String refresh;

  Token({
    @required this.access,
    @required this.refresh,
  }) : super([access, refresh]);
}