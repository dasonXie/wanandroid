import 'package:flutter/material.dart';

import 'login/page/login.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 60),
        child: InkWell(
          child: Text("侧滑栏"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => LoginPage()));
          },
        ),
      ),
    );
  }
}
