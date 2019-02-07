import 'package:flutter/material.dart';
import 'OutputScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ASL 2 GO',
//        theme: new ThemeData(
//            primaryTextTheme: TextTheme(
//                title: TextStyle(
//                    color: Colors.blue
//                )
//            )
//        ),
//        home: MyHomePage(title: 'ASL 2 GO'),
      home: OutputScreen(),
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
      backgroundColor: Colors.pink,
      appBar: null,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'ASL',
              style: TextStyle(
                fontSize: 80,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '— 2 —',
              style: TextStyle(
                fontSize: 80,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'GO',
              style: TextStyle(
                fontSize: 80,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              height: 150,
            ),

          ButtonTheme(
            minWidth: 200.0,
            height: 50.0,
            buttonColor: Colors.white,
            child: RaisedButton(
              child: Text(
                  "Get Started",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
//              disabledColor: Colors.white,
//              disabledTextColor: Colors.black,
              onPressed: () {},
            )
          )
          ],
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: null,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
