import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

int kPORT = 65421;

Future main() async {
  await DotEnv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  String matchIP(String res) {
    RegExp regex = RegExp(r'(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*' +
        '${DotEnv.env['MAC_ADDRESS']}');
    final match = regex.firstMatch(res);
    return match.group(1);
  }

  Future<String> getPCIP() async {
    final result = await Process.run('ip', ['neighbor']);
    return matchIP(result.stdout);
  }

  Future<void> sendServerData() async {
    final socket =
        await Socket.connect(InternetAddress(await getPCIP()), kPORT);
    print('Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');
    // final result = await Process.run('ip', ['neighbor']);
    socket.write('Test');
    socket.close();
  }

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
            MaterialButton(
              color: Colors.red,
              onPressed: sendServerData,
              child: Text('Press Me'),
            ),
            Text(
              'You have pushed the button this many:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
