import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:game_keyboard/screens/service_button.dart';

Future main() async {
  await DotEnv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Keyboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Game Keyboard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ServiceButton(buttonText: 'Fly Plane', serviceData: 'fly_plane'),
            ServiceButton(buttonText: 'Fly Heli', serviceData: 'fly_heli'),
            ServiceButton(buttonText: 'Test', serviceData: 'test'),
            ServiceButton(
                buttonText: 'Plasma Cutter', serviceData: 'cut_glass'),
            ServiceButton(buttonText: 'Screenshot', serviceData: 'take_ss'),
            GestureDetector(
              onTapDown: (x) {
                print('Down');
                print(x.kind);
              },
              onTapUp: (x) {
                print('Up');
                print(x.kind);
              },
              child: Container(
                color: Colors.yellow.shade600,
                padding: const EdgeInsets.all(8),
                child: Text('TURN LIGHTS ON'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
