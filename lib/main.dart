import 'package:flutter/material.dart';
import 'dart:convert';
import 'repo.dart';
import 'package:http/http.dart' as http;
import 'description.dart';

void main() => runApp(SampleApp());


class SampleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SamplePage(title: 'Git Repo'),
    );
  }
}

class SamplePage extends StatefulWidget {
  SamplePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  List<Repo> widgets = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  showLoadingDialog() {
    if (widgets.length == 0) {
      return true;
    }

    return false;
  }

  getProgressDialog() {
    return Center(child: CircularProgressIndicator());
  }

  Widget getRow(int position) {
//    return Padding(padding: EdgeInsets.all(10.0), child: Text("${widgets[i].full_name}"));
    return Card(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Divider(height: 5.0),
        ListTile(
          dense: true,
          title: Text(
            '${widgets[position].name}',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.deepOrangeAccent,
            ),
          ),
          subtitle: Text(
            '${widgets[position].description}',
            style: new TextStyle(
              fontSize: 18.0,
              fontStyle: FontStyle.italic,
            ),
          ),
          leading: Column(
            children: <Widget>[
              Image.network(
                widgets[position].owner.avatar_url,
                fit: BoxFit.cover,
                height: 60,
                width: 60,
                alignment: Alignment.center,
              ),
            ],
          ),
          onTap: () => _onTapItem(context, widgets[position]),
        ),
      ],
    ));
  }

  ListView getListView() => ListView.builder(
      itemCount: widgets.length,
      padding: const EdgeInsets.all(15.0),
      itemBuilder: (BuildContext context, int position){
//        return getRow(position);
        return getRow(position);
      });

  void _onTapItem(BuildContext context, Repo repo) {
    var url = repo.html_url;
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new DescriptionPage(url),
        ));
//    Scaffold
//        .of(context)
//        .showSnackBar(new SnackBar(content: new Text(repo.id.toString() + ' - ' + repo.name)));
  }

  getBody() {
    if (showLoadingDialog()) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  loadData() async {
    String dataURL = "https://api.github.com/users/square/repos";
    http.Response response = await http.get(dataURL);
    setState(() {
      if (response.statusCode == 200) {
        List responseJson = json.decode(response.body);
        widgets = responseJson.map((i) => Repo.fromJson(i)).toList();
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load post');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: getBody(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
