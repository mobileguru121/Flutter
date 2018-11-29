import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(new DescriptionPage(null));
}

class DescriptionPage extends StatelessWidget {
  static String tag = 'description-page';
  DescriptionPage(this.url_repo);
  final String url_repo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Full Repo",
          style: new TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: new MaterialApp(
        routes: {
          "/": (_) => new WebviewScaffold(
            url: url_repo,
            appBar: new AppBar(title: new Text("")),
          )
        },
      ),
    );
  }
}