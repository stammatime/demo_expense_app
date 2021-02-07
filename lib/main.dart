import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  // we need this before orientation call to ensure that binding is intialized before calling RunApp
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracking App',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
        //primaryColor => One single color
        //primarySwatch => Grouping of colors
        primarySwatch: Colors.green,
        accentColor: Colors.greenAccent,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            button: TextStyle(color: Colors.white)),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: 't1',
    //     title: 'Gift',
    //     amount: 38.99,
    //     date: DateTime.now().subtract(Duration(days: 1))),
    // // Transaction(
    // //     id: 't2',
    // //     title: 'Art',
    // //     amount: 50.44,
    // //     date: DateTime.now().subtract(Duration(days: 2))),
    // Transaction(
    //     id: 't3',
    //     title: 'Primogems',
    //     amount: 22,
    //     date: DateTime.now().subtract(Duration(days: 3))),
    // Transaction(
    //     id: 't4',
    //     title: 'New Shoes',
    //     amount: 150,
    //     date: DateTime.now().subtract(Duration(days: 3))),
    // // Transaction(
    // //     id: 't5',
    // //     title: 'GME stock',
    // //     amount: 60,
    // //     date: DateTime.now().subtract(Duration(days: 4))),
    // // Transaction(
    // //     id: 't6',
    // //     title: 'Groceries',
    // //     amount: 42.69,
    // //     date: DateTime.now().subtract(Duration(days: 5))),
    // Transaction(
    //     id: 't7',
    //     title: 'Takeout',
    //     amount: 25.53,
    //     date: DateTime.now().subtract(Duration(days: 6)))
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: chosenDate);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              // onTap and behavior not needed but interesting example
              onTap: () {
                // print('tapped');
              },
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(_addNewTransaction));
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    // I should extend
    bool isIOS = false;
    bool isAndroid = false;
    bool isWeb = false;
    try {
      if (Platform.isIOS)
        isIOS = true;
      else if (Platform.isAndroid) isAndroid = true;
    } catch (e) {
      isWeb = true;
    }

    final mediaQuery = MediaQuery.of(context);
    final _isLandscape =
        mediaQuery.orientation == Orientation.landscape && !isWeb;
    final PreferredSizeWidget appBar = isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expense'),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context))
            ]))
        : AppBar(
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _startAddNewTransaction(context);
                  })
            ],
            title: Text('Expense Tracking App'),
          );
    var txListWidget = Container(
        child: TransactionList(_userTransactions, _deleteTransaction),
        height: (mediaQuery.size.height * 1) -
            appBar.preferredSize.height -
            mediaQuery.padding.top);

    var pageBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (_isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('show chart',
                    style: Theme.of(context).textTheme.headline6),
                Switch.adaptive(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    })
              ],
            ),
          if (!_isLandscape)
            Container(
                child: Chart(_recentTransactions),
                height: (mediaQuery.size.height * .3) -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top),
          if (!_isLandscape) txListWidget,
          if (_isLandscape)
            _showChart
                ? Container(
                    child: Chart(_recentTransactions),
                    height: (mediaQuery.size.height * .7) -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top)
                : txListWidget,
        ],
      ),
    ));
    return isIOS
        ? CupertinoPageScaffold(child: pageBody)
        : Scaffold(
            appBar: appBar,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      _startAddNewTransaction(context);
                    }),
            body: pageBody);
  }
}
