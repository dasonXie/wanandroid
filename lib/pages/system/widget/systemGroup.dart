import 'package:flutter/material.dart';
import 'package:wanandroid/pages/system/widget/systemItem.dart';
import 'package:wanandroid/pages/system/model/systemModel.dart';

class SystemGroup extends StatelessWidget {
  final SystemModel modelList;

  const SystemGroup(this.modelList, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            modelList.name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 10,
            runSpacing: -5,
            children: [
              for (var model in modelList.children) SystemItem(model.name)
            ],
          ),
        ],
      ),
    );
  }
}
