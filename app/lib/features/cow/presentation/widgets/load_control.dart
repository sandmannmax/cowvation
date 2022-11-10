import 'package:cowvation/features/cow/presentation/bloc/cow_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadControl extends StatefulWidget {
  final int cowNumber;

  LoadControl({ @required this.cowNumber }) : super();

  @override
  _LoadControlState createState() => _LoadControlState(cowNumber: cowNumber);
}

class _LoadControlState extends State<LoadControl> {
  final int cowNumber;

  _LoadControlState({ @required this.cowNumber }) : super();

  @override
  void initState() {
    _dispatchGetCow(this.cowNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  void _dispatchGetCow(int cowNumber) {
    BlocProvider.of<CowBloc>(context).add(GetCowE(cowNumber));
  }
}
