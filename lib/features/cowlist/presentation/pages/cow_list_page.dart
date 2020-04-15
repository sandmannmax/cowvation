import 'package:cowvation/features/cowlist/presentation/bloc/cow_list_bloc.dart';
import 'package:cowvation/features/cowlist/presentation/widgets/list_widget.dart';
import 'package:cowvation/features/cowlist/presentation/widgets/load_control.dart';
import 'package:cowvation/features/cowlist/presentation/widgets/loading_widget.dart';
import 'package:cowvation/features/cowlist/presentation/widgets/message_display_widget.dart';
import 'package:cowvation/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CowListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  BlocProvider<CowListBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CowListBloc>(),
      child: Column(
        children: <Widget>[
          LoadControl(),
          BlocBuilder<CowListBloc, CowListState>(
            builder: (context, state) {
              if (state is Empty) {
                return MessageDisplay(message: 'empty');
              } else if (state is Error) {
                return MessageDisplay(message: state.message);
              } else if (state is Loading) {
                return LoadingWidget();
              } else if (state is Loaded) {
                return ListWidget(cowList: state.cowList);
              }
              return MessageDisplay(message: 'else');
            },
          ),
        ],
      ),
    );
  }
}

