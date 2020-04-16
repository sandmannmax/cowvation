import 'package:cowvation/features/cow/presentation/pages/cow_page.dart';
import 'package:cowvation/features/cowlist/domain/entities/cow.dart';
import 'package:cowvation/features/login/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

class ListWidget extends StatefulWidget {
  final List<Cow> cowList;

  const ListWidget({
    Key key,
    @required this.cowList,
  }) : super(key: key);

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: _getWidgetList(widget.cowList),
      ),
    );
  }

  List<Widget> _getWidgetList(List<Cow> list) {
    List<Widget> widgetList = List<Widget>();
    list.forEach((item) {
      widgetList.add(
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CowPage(cowNumber: item.number,)));
          },
          child: Row(
            children: <Widget>[
              Expanded(child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 16.0, 0.0, 16.0),
                child: Text(item.number.toString(), style: TextStyle(fontSize: 25)),
              )),
              Expanded(child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 16.0, 0.0, 16.0),
                child: Text(item.numberEar.toString(), style: TextStyle(fontSize: 25)),
              )),
              Expanded(child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 16.0, 0.0, 16.0),
                child: Text(item.race, style: TextStyle(fontSize: 25)),
              )),
            ], 
          ),
        ),
      );
    });
    return widgetList;
  }
}