import 'package:cowvation/features/cow/presentation/bloc/cow_bloc.dart';
import 'package:cowvation/features/cow/presentation/widgets/load_control.dart';
import 'package:cowvation/core/widgets/loading_widget.dart';
import 'package:cowvation/core/widgets/message_display_widget.dart';
import 'package:cowvation/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CowPage extends StatelessWidget {
  final int cowNumber;

  CowPage({ @required this.cowNumber }) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CowVation - Kuh'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<CowBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CowBloc>(),
      child: Column(
        children: <Widget>[
          LoadControl(cowNumber: this.cowNumber),
          BlocBuilder<CowBloc, CowState>(
            builder: (context, state) {
              if (state is Error) {
                return MessageDisplay(message: state.message);
              } else if (state is Loading) {
                return LoadingWidget();
              } else if (state is Loaded) {
                return MessageDisplay(message: state.cow.number.toString());
              }
              return MessageDisplay(message: 'else');
            },
          ),
        ],
      ),
    );
  }
}

