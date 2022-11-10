import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final List<Params> params;
  List<Widget> items = List<Widget>();

  InputWidget({
    Key key,
    @required this.params,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    params.forEach((param) {
      items.add(Expanded(
        child: TextFormField(
          validator: (String v) {
            if(v.isEmpty) {
              return 'Geben Sie einen Benutzernamen ein!';
            }
          },
          style: TextStyle(
            fontSize: 16,
          ),
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              labelText: param.description),
          onChanged: param.onChange,
        ),
      ));
    });
    int l = items.length;
    if (l > 1) {
      for (var i = l-1; i > 0 ; i--) {
        items.insert(i, SizedBox(
          width: 10,
        ));
      }    
    }     
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
      child: Row(
        children: items,
      ),
    );
  }
}

class Params extends Equatable {
  final String description;
  final ValueChanged<dynamic> onChange;

  Params({
    @required this.description, 
    @required this.onChange
  }) : super([description, onChange]);
}
