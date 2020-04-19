import 'package:cowvation/features/cow/presentation/bloc_add/cow_add_bloc.dart';
import 'package:cowvation/features/cow/presentation/widgets/cow_add_widget.dart';
import 'package:cowvation/core/widgets/message_display_widget.dart';
import 'package:cowvation/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CowAddPage extends StatelessWidget {

  CowAddPage() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kuh hinzufügen'),
        centerTitle: true,
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<CowAddBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CowAddBloc>(),
      child: Column(
        children: <Widget>[
          BlocBuilder<CowAddBloc, CowAddState>(
            builder: (context, state) {
              if (state is Insert) {
                return CowAddWidget();
              } else if (state is Loading) {
                return CowAddWidget();
              } else if (state is Loaded) {
                return CowAddWidget();
              } else if (state is Error) {
                return CowAddWidget();
              }
              return MessageDisplay(message: 'else');
            },
          ),
        ],
      ),
    );
  }
}