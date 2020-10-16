import 'package:flutter/material.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("引导页"),
      ),
      body: Column(
        children: <Widget>[
          PageView(
            children: <Widget>[
              Text("1"),
              Text("2"),
              Text("3"),
            ],
            onPageChanged: (value) {
              print(value);
            },
            physics: ClampingScrollPhysics(),
          ),
          DotIndicator(),
        ],
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      color: Colors.red,
    );
  }
}
