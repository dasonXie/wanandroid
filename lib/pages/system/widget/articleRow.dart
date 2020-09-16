import 'package:flutter/material.dart';
import 'package:wanandroid/network/networkManager.dart';
import 'package:wanandroid/pages/system/model/systemArticleModel.dart';
import 'package:wanandroid/network/api.dart';
import 'package:wanandroid/model/baseModel.dart';

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
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Text(
                  model.superChapterName,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
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
            InkWell(
              child: Icon(
                Icons.favorite,
                color: Colors.grey,
              ),
              onTap: () async {
                collect(model.id);
              },
            ),
            SizedBox(
              width: 10,
            ),
            Text(model.shareUser,
                style: TextStyle(fontSize: 12, color: Colors.grey)),
            SizedBox(
              width: 10,
            ),
            Text(model.niceDate,
                style: TextStyle(fontSize: 12, color: Colors.grey))
          ],
        )
      ],
    );
  }

//收藏按钮
  collect(int id) async {
    var res = await NetworkManager.getInstance()
        .request(WanAndroidApi.lg_collect + "/$id" + "/json");

    // var model = BaseResp<String>(res, (res) => String)

    print(res);
  }
}
