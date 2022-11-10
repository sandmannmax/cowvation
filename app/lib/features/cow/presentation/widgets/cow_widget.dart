import 'package:cowvation/features/cow/presentation/widgets/cow_row_widget.dart';
import 'package:cowvation/features/cow/domain/entities/cow.dart';
import 'package:flutter/material.dart';

class CowWidget extends StatelessWidget {
  final Cow cow;

  const CowWidget({
    @required this.cow,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CowRowWidget(description: 'Kuhnummer:', text: cow.number.toString()),
        CowRowWidget(description: 'Ohrnummer:', text: cow.numberEar.toString()),
        CowRowWidget(description: 'Rasse:', text: cow.race),
        CowRowWidget(description: 'Farbtendenz:', text: cow.colorTendency),
        CowRowWidget(description: 'Größe:', text: cow.height),
        CowRowWidget(description: 'Handkuh:', text: cow.manual ? 'Ja' : 'Nein'),
        CowRowWidget(description: 'Holkuh:', text: cow.fetch ? 'Ja' : 'Nein'),
        CowRowWidget(description: 'Gruppe:', text: cow.group),
      ],
    );
  }
}

