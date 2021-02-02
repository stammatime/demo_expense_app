import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class NewTransaction extends StatelessWidget {
  final Function addTransaction;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTransaction);

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    print('called');
    if (enteredTitle.isEmpty || enteredAmount <= 0 || enteredAmount == null) {
      return;
    }
    addTransaction(enteredTitle, enteredAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: titleController,
                  onSubmitted: (_) => submitData), // not sure why we have this
              TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [CurrencyTextInputFormatter()],
                  onSubmitted: (_) => submitData), // not sure why we have this
              TextButton(
                  style: TextButton.styleFrom(primary: Colors.purple),
                  onPressed: submitData,
                  child: Text('Add Transaction')),
            ],
          ),
        ));
  }
}
