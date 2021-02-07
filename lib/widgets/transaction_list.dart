import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final Function _deleteTransaction;
  final List<Transaction> _transactions;

  TransactionList(this._transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text('No Transactions added yet!',
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 100),
                Container(
                  height: constraints.maxHeight * .6,
                  child: Image.asset(
                    'images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: CircleAvatar(
                            radius: 30,
                            child: Text('\$${_transactions[index].amount}')),
                      ),
                    ),
                    title: Text(_transactions[index].title,
                        style: Theme.of(context).textTheme.headline6),
                    subtitle: Text(
                        DateFormat.yMMMd().format(_transactions[index].date)),
                    trailing: MediaQuery.of(context).size.width > 320 &&
                            MediaQuery.of(context).size.height > 320
                        ? TextButton.icon(
                            style: TextButton.styleFrom(
                                primary: Theme.of(context).errorColor),
                            icon: Icon(Icons.delete),
                            label: Text('Delete'),
                            onPressed: () =>
                                _deleteTransaction(_transactions[index].id),
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () =>
                                _deleteTransaction(_transactions[index].id),
                          )),
              );
              // Card(
              //     child: Row(
              //   children: <Widget>[
              //     Container(
              //         margin:
              //             EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              //         decoration: BoxDecoration(
              //             border: Border.all(
              //                 color: Theme.of(context).primaryColor,
              //                 width: 2)),
              //         padding: EdgeInsets.all(10),
              //         child: Text(
              //             ('\$ ${_transactions[index].amount.toStringAsFixed(2)}'),
              //             style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 20,
              //                 color: Theme.of(context).primaryColor))),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: <Widget>[
              //         Text(_transactions[index].title,
              //             style: Theme.of(context).textTheme.headline6),
              //         Text(
              //             DateFormat.yMMMd()
              //                 .format(_transactions[index].date),
              //             style: TextStyle(color: Colors.grey, fontSize: 12))
              //       ],
              //     )
              //   ],
              // ));
            },
            itemCount: _transactions.length,
          );
  }
}
