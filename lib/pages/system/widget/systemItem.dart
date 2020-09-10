import 'package:flutter/material.dart';
import 'dart:math';

class SystemItem extends StatelessWidget {
  final name;

  const SystemItem(this.name, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: randomColor(),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Text(name),
      onPressed: () {
        print("$name");
      },
    );
  }

  ///随机色
  randomColor() {
    return Color.fromRGBO(
        Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);
  }
}
