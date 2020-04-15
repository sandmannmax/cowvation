import 'package:cowvation/features/login/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'injection_container.dart' as di;
import 'package:logging/logging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      theme: ThemeData(
        primaryColor: Colors.blue.shade600,
        accentColor: Colors.blue.shade600,
      ),
      home: LoginPage(),
    );
  }
}
