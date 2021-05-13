import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mati_flutter/mati_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';


final clientId = "5c94e3c401ddc6001be83c07"; // TODO change to CLIENT_ID
final flowId = "5e962a23728ddc001b5937aa"; // TODO change to FLOW_ID
final metadata = Map<String, dynamic>()
  ..["key1"] = "String value"
  ..["key2"] = 2;

void main() {
  runApp(ClientApp());
}

class ClientApp extends StatefulWidget {
  @override
  _ClientAppState createState() => _ClientAppState();
}

class _ClientAppState extends State<ClientApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    MatiFlutter.resultCompleter.future.then((result) => Fluttertoast.showToast(
      msg: result is ResultSuccess ? "Success ${result.verificationId}" : "Cancelled",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM));
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    MatiFlutter.setParams(clientId, flowId, metadata);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: TextButton (
            child: Text(
              _platformVersion.toUpperCase()),
            onPressed: () async => {
              log(await MatiFlutter.showMatiFlow())
            }
          ),
        ),
      ),
    );
  }
}