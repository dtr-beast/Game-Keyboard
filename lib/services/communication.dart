import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

import '../constants.dart';

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

Future<void> sendServerData({String serviceData}) async {
  final socket = await Socket.connect(InternetAddress(await getPCIP()), kPORT);
  print('Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');
  socket.write(serviceData);
  socket.close();
}
