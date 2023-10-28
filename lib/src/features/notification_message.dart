import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationMessage extends StatefulWidget {
  const NotificationMessage({super.key});

  @override
  State<NotificationMessage> createState() => _NotificationMessageState();
}

class _NotificationMessageState extends State<NotificationMessage> {
  String message = "";

  @override
  void didChangeDependencies() {
    final argument = Get.arguments;
    if (argument != null) {
      Map? pushArguments = argument as Map;
      setState(() {
        message = pushArguments["message"];
      });
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.blue,
          child: Text(message, style: const TextStyle(color: Colors.red),),
        ),
      ),
    );
  }
}