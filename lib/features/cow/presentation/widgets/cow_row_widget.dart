import 'package:flutter/material.dart';

class CowRowWidget extends StatelessWidget {
  final String description;
  final String text;

  const CowRowWidget({
    Key key,
    @required this.description,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            this.description
          ),
        ),
        Expanded(
          child: Text(
            this.text
          ),
        ),
      ],
    );
  }
}