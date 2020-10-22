import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(new MyApp());
}

// ...
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  InAppWebViewController webView;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
            child: Column(children: <Widget>[
          Expanded(
            child: Container(
                child: InAppWebView(
              initialUrl: 'https://www.nokia.com/',
              initialHeaders: {},
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    javaScriptEnabled: true,
                    debuggingEnabled: true,
                  ),
                  android: AndroidInAppWebViewOptions()),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onLoadStart: (InAppWebViewController controller, String url) {},
              onLoadStop:
                  (InAppWebViewController controller, String url) async {},
              onLoadError: (InAppWebViewController controller, String url,
                  int a, String b) async {},
              onLoadHttpError:
                  (controller, url, statusCode, description) async {},
            )),
          )
        ])),
      ),
    );
  }
}
