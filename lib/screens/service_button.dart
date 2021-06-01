import 'package:flutter/material.dart';
import 'package:game_keyboard/services/communication.dart';

class ServiceButton extends StatelessWidget {
  ServiceButton({@required this.buttonText, @required this.serviceData});

  final String serviceData, buttonText;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white54,
      onPressed: () => sendServerData(serviceData: serviceData),
      child: Text(buttonText),
    );
  }
}
