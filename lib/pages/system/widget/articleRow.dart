import 'package:flutter/material.dart';
import 'package:wanandroid/pages/system/model/systemArticleModel.dart';

class ArticleRow extends StatelessWidget {
  final ArticleModel model;
  const ArticleRow(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(child: sdfsdf()),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.blue,
              child: Text(
                model.superChapterName,
                style: TextStyle(fontSize: 11, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  sdfsdf() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          model.title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Row(
          children: [
            Text(model.niceDate,
                style: TextStyle(fontSize: 12, color: Colors.grey))
          ],
        )
      ],
    );
  }

  sdfsdf1() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            model.title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(model.niceDate,
              style: TextStyle(fontSize: 12, color: Colors.grey)),
        ),
      ],
    );
  }

  sdfsdf2() {
    return Stack(
      children: [
        Positioned(
          child: Text(
            model.title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        Positioned(
          bottom: -10,
          child: Text(model.niceDate,
              style: TextStyle(fontSize: 12, color: Colors.grey)),
        ),
      ],
    );
  }

  sdfsdf3() {
    return Column(children: [
      Container(
        height: 10,
        color: Colors.yellow,
      )
    ]);
  }
}
