import 'package:cupertino_datepicker_example/page/timer_page.dart';
import 'package:cupertino_datepicker_example/widget/tabbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Clock App';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: new ThemeData(scaffoldBackgroundColor: const Color(0x000000)),
        home: MainPage(),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => TabBarWidget(
        title: 'Clock App',
        tabs: [
          Tab(icon: Icon(Icons.timer), text: 'Clock'),
          Tab(icon: Icon(Icons.timer), text: 'Stopwatch'),
          Tab(icon: Icon(Icons.timer), text: 'Timer'),
        ],
        children: [
          TimerPickerPage(),
          TimerPickerPage(),
          TimerPickerPage(),
        ],
      );
}
