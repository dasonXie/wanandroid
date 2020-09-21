import 'package:flutter/material.dart';

class LikeBtn extends StatelessWidget {
  const LikeBtn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      child: new Icon(
        Icons.favorite,
        color: (true) ? Colors.redAccent : Colors.grey,
      ),
    );
  }
}
