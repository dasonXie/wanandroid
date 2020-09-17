import 'package:flutter/material.dart';

class WholeButton extends StatelessWidget {
  Widget text;
  int flex;
  Decoration decoration;
  VoidCallback onPressedFunc;

  WholeButton(this.text,
      {Key key, this.flex = 18, @required this.onPressedFunc, this.decoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(),
          ),
          Expanded(
            flex: flex,
            child: Container(
              child: FlatButton(
                  child: text,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () =>
                      onPressedFunc == null ? null : onPressedFunc()),
              decoration: decoration,
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
