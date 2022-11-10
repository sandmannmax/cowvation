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
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 5.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              this.description,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: Text(
              this.text,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}