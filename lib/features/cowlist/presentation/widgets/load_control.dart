import 'package:cowvation/features/cowlist/presentation/bloc/cow_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadControl extends StatefulWidget {
  @override
  _LoadControlState createState() => _LoadControlState();
}

class _LoadControlState extends State<LoadControl> {
  @override
  void initState() {
    _dispatchGetCowList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  void _dispatchGetCowList() {
    BlocProvider.of<CowListBloc>(context).add(GetCowListE());
  }
}
