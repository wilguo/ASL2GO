import 'package:flutter/material.dart';

void main() => runApp(new Result());

class Result extends StatefulWidget {
  Result({Key key, this.resultText}) : super(key: key);
  final String resultText;

  @override
  _ResultState createState() => new _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Translate result"),
        ),
        body: ListView(
          children: <Widget>[
            Text("Your result:\n" + widget.resultText)
          ],
        )
    );
  }
}