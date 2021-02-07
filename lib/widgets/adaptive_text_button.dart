import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextButton extends StatelessWidget {
  final String text;
  final Function handler;

  AdaptiveTextButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    bool isIOS;
    try {
      if (Platform.isIOS)
        isIOS = true;
      else
        isIOS = false;
    } catch (e) {
      isIOS = false;
    }
    return isIOS
        ? CupertinoButton(
            child: Text('Choose Date',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: handler,
          )
        : TextButton(
            style:
                TextButton.styleFrom(primary: Theme.of(context).primaryColor),
            child: Text('Choose Date',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: handler,
          );
  }
}
