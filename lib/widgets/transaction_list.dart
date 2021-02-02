import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
              child: Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple, width: 2)),
                  padding: EdgeInsets.all(10),
                  child: Text(
                      ('\$ ${_transactions[index].amount.toStringAsFixed(2)}'),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_transactions[index].title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(DateFormat.yMMMd().format(_transactions[index].date),
                      style: TextStyle(color: Colors.grey, fontSize: 12))
                ],
              )
            ],
          ));
        },
        itemCount: _transactions.length,
      ),
    );
  }
}
