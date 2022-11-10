import 'package:cowvation/features/cow/presentation/pages/cow_add_page.dart';
import 'package:cowvation/features/cowlist/presentation/pages/cow_list_page.dart';
import 'package:cowvation/core/widgets/message_display_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
      appBar: _buildAppBar(),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/cowvationLogo.png')),
            title: Text('Kühe'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings), 
            title: Text('Einstellungen')
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  AppBar _buildAppBar() {
    switch (_currentIndex) {
      case 0:
        return AppBar(
          title: Text('Home'),
          centerTitle: true,
        );
      case 1:
        return AppBar(
          title: Text('Kühe'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search, 
                color: Colors.white
              ), 
              onPressed: () {}
            ),
            IconButton(
              icon: Icon(
                Icons.add, 
                color: Colors.white
              ), 
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CowAddPage())
                );
              }
            ),
          ],
        );
      case 2:
        return AppBar(
          title: Text('Einstellungen'),
          centerTitle: true,
        );
      default:
        return AppBar(
          title: Text('CowVation'),
          centerTitle: true,
        );
    }
  }
}
