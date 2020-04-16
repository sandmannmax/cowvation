import 'package:cowvation/features/cowlist/presentation/pages/cow_list_page.dart';
import 'package:cowvation/core/widgets/message_display_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Flex(
      direction: Axis.vertical,
      children: <Widget>[
        MessageDisplay(
          message: 'Home'
        ),
      ],
    ),
    CowListPage(),
    Flex(
      direction: Axis.vertical,
      children: <Widget>[
        MessageDisplay(
          message: 'Einstellungen'
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CowVation - Home'),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.queue),
            title: new Text('Kühe'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text('Einstellungen'))
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
