import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Token extends Equatable {
  final String access;
  final String refresh;
  final DateTime firstFetch;
  final DateTime accessFetch;

  Token({
    @required this.access,
    @required this.refresh,
    @required this.firstFetch,
    @required this.accessFetch
  }) : super([access, refresh, firstFetch, accessFetch]);
}