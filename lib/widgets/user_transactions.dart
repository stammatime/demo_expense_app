import 'package:flutter/material.dart';
import './new_transaction.dart';
import 'transaction_list.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final _userTransactions = [
    Transaction(id: 't1', title: 'Gift', amount: 69.99, date: DateTime.now()),
    Transaction(id: 't1', title: 'Art', amount: 88, date: DateTime.now()),
    Transaction(id: 't1', title: 'Primogems', amount: 22, date: DateTime.now()),
    Transaction(id: 't1', title: 'New Shoes', amount: 50, date: DateTime.now()),
    Transaction(
        id: 't1', title: 'New Shoes', amount: 29.99, date: DateTime.now()),
    Transaction(
        id: 't1', title: 'Groceries', amount: 420.69, date: DateTime.now()),
    Transaction(id: 't2', title: 'Takeout', amount: 16.53, date: DateTime.now())
  ];

  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      NewTransaction(_addNewTransaction),
      TransactionList(_userTransactions)
    ]);
  }
}
