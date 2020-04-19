import 'package:camera/camera.dart';
import 'package:cowvation/features/home/home_page.dart';
import 'package:cowvation/features/login/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'injection_container.dart' as di;
import 'package:logging/logging.dart';

CameraDescription firstCamera;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  firstCamera = cameras.first;
  await di.init();
  //_setupLogging();
  runApp(MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CowVation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueGrey.shade700,
        accentColor: Colors.deepOrangeAccent,
        scaffoldBackgroundColor: Colors.grey.shade900,
        brightness: Brightness.dark,
        fontFamily: 'Quicksand',
      ),
      home: LoginPage(),
    );
  }
}
