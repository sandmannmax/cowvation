import 'package:cowvation/features/cow/presentation/bloc/cow_bloc.dart';
import 'package:cowvation/features/cow/presentation/widgets/cow_row_widget.dart';
import 'package:flutter/material.dart';

class CowWidget extends StatelessWidget {
  final Loaded state;

  const CowWidget({
    @required this.state,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Placeholder(
          fallbackHeight: MediaQuery.of(context).size.height / 3,
        ),
        CowRowWidget(description: 'Kuhnummer:', text: state.cow.number.toString()),
        CowRowWidget(description: 'Ohrnummer:', text: state.cow.numberEar.toString()),
        CowRowWidget(description: 'Rasse:', text: state.cow.race),
        CowRowWidget(description: 'Farbtendenz:', text: state.cow.colorTendency),
        CowRowWidget(description: 'Größe:', text: state.cow.height),
        CowRowWidget(description: 'Handkuh:', text: state.cow.manual ? 'Ja' : 'Nein'),
        CowRowWidget(description: 'Holkuh:', text: state.cow.fetch ? 'Ja' : 'Nein'),
        CowRowWidget(description: 'Gruppe:', text: state.cow.group),
      ],
    );
  }
}

