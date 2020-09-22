import 'package:flutter/material.dart';

class Toast {
  ///底部吐司。
  ///因为需要一个context，所以使用起来不是很方便
  static show(context, String text,
      {String label = "", VoidCallback onPressed}) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: label,
        onPressed: () => onPressed == null ? null : onPressed(),
      ),
      duration: Duration(milliseconds: 2000),
    ));
  }
}
