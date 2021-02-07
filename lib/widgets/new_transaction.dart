import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction) {
    // print('new widget instance');
  }

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  DateTime _selectedDate = DateTime.now();

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
      return;
    });
  }

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount =
        double.parse(_amountController.text.replaceAll(',', ''));
    // print('called');
    if (enteredTitle.isEmpty ||
        enteredAmount <= 0 ||
        enteredAmount == null ||
        _selectedDate == null) {
      return;
    }
    // print('added');
    widget.addTransaction(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                    onSubmitted: (_) =>
                        _submitData), // not sure why we have this
                TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    controller: _amountController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                    ],
                    onSubmitted: (_) => _submitData),
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(_selectedDate == null
                            ? 'No Date Chosen!'
                            : 'Transaction Date: ${DateFormat.yMd().format(_selectedDate)}'),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            primary: Theme.of(context).primaryColor),
                        child: Text('Choose Date',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        onPressed: _presentDatePicker,
                      ),
                    ],
                  ),
                ), // not sure why we have this
                Platform.isIOS
                    ? CupertinoButton(
                        onPressed: _submitData, child: Text('Add Transaction'))
                    : ElevatedButton(
                        onPressed: _submitData, child: Text('Add Transaction')),
              ],
            ),
          )),
    );
  }
}
