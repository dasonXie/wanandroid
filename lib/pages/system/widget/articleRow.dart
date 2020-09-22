import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanandroid/network/networkManager.dart';
import 'package:wanandroid/pages/system/model/systemArticleModel.dart';
import 'package:wanandroid/network/api.dart';
import 'package:wanandroid/model/baseModel.dart';

class ArticleRow extends StatefulWidget {
  final ArticleModel model;
  ArticleRow(this.model, {Key key}) : super(key: key);

  @override
  _ArticleRowState createState() => _ArticleRowState();
}

class _ArticleRowState extends State<ArticleRow> {
  RefreshBLoC bloc = RefreshBLoC();

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
                  widget.model.superChapterName,
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
          widget.model.title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Row(
          children: [
            StreamBuilder(
              stream: bloc.steream,
              initialData: 0,
              builder: (context, snapshot) {
                return InkWell(
                  child: Icon(
                    Icons.favorite,
                    color: widget.model.collect ? Colors.red : Colors.grey,
                  ),
                  onTap: () async {
                    if (widget.model.collect) {
                      //取消收藏
                      uncollect(widget.model);
                    } else {
                      //收藏
                      collect(widget.model);
                    }
                  },
                );
              },
            ),
            SizedBox(
              width: 10,
            ),
            Text(widget.model.shareUser,
                style: TextStyle(fontSize: 12, color: Colors.grey)),
            SizedBox(
              width: 10,
            ),
            Text(widget.model.niceDate,
                style: TextStyle(fontSize: 12, color: Colors.grey))
          ],
        )
      ],
    );
  }

//收藏按钮
  collect(ArticleModel model) async {
    var res = await NetworkManager.getInstance().request(
        WanAndroidApi.lg_collect + "/" + model.id.toString() + "/json");

    var result = BaseResp<String>(res, (res) {
      return res;
    });

    if (result.code == 0) {
      //收藏成功才刷新
      model.collect = !model.collect;
      bloc.refresh();
    }
  }

  //取消收藏按钮
  uncollect(ArticleModel model) async {
    var res = await NetworkManager.getInstance().request(
        WanAndroidApi.lg_uncollect_originid +
            "/" +
            model.id.toString() +
            "/json");

    var result = BaseResp<String>(res, (res) {
      return res;
    });

    if (result.code == 0) {
      //取消收藏成功才刷新
      model.collect = !model.collect;
      bloc.refresh();
    }
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}

//BLoC通道流
//BLoC的时候还是要用在StatefulWidget，并且手动的调用一下dispose，否则可能会有不可预测的bug
class RefreshBLoC {
  var _controllerStream = StreamController<int>();

  Stream<int> get steream => _controllerStream.stream;

  refresh() {
    _controllerStream.sink.add(1);
  }

  dispose() {
    _controllerStream.close();
  }
}
