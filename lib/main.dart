import 'package:flutter/material.dart';
import './widgets/user_transactions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add), onPressed: () {})
          ],
          title: Text('Flutter App'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:
            FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: Colors.blue,
                width: double.infinity,
                child: Card(
                  color: Colors.blue,
                  child: Text('Chart!'),
                  elevation: 5,
                ),
              ),
              UserTransactions(),
            ],
          ),
        ));
  }
}
