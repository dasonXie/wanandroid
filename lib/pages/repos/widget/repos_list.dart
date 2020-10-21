import 'package:flutter/material.dart';
import 'package:wanandroid/model/baseModel.dart';
import 'package:wanandroid/network/api.dart';
import 'package:wanandroid/network/networkManager.dart';
import 'package:wanandroid/pages/repos/model/projectListModel.dart';
import 'package:wanandroid/pages/repos/page/web_page.dart';
import 'package:wanandroid/pages/system/widget/articleRow.dart';
import 'package:wanandroid/pages/time_utils.dart';

class ReposList extends StatefulWidget {
  final ProjectListModel listModel;
  ReposList(this.listModel, {Key key}) : super(key: key);

  @override
  _ReposListState createState() => _ReposListState();
}

class _ReposListState extends State<ReposList> {
  RefreshBLoC bloc = RefreshBLoC();
  @override
  Widget build(BuildContext context) {
    return new InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return WebPage(
                widget.listModel.link,
                title: widget.listModel.title,
              );
            },
          ));
        },
        child: Container(
            height: 140.0,
            padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 10),
            child: new Row(
              children: <Widget>[
                new Expanded(
                    child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(widget.listModel.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18, color: Colors.black87)),
                    new SizedBox(height: 10),
                    new Expanded(
                      // flex: 1,
                      child: new Text(
                        widget.listModel.desc,
                        maxLines: 3,
                        // softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13, color: Colors.black45),
                      ),
                    ),
                    new SizedBox(height: 10),
                    new Row(
                      children: <Widget>[
                        StreamBuilder(
                          stream: bloc.steream,
                          initialData: 0,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            return Container(
                              child: InkWell(
                                onTap: () async {
                                  if (widget.listModel.collect) {
                                    //取消收藏
                                    uncollect(widget.listModel);
                                  } else {
                                    //收藏
                                    collect(widget.listModel);
                                  }
                                },
                                child: Icon(
                                  Icons.favorite,
                                  color: widget.listModel.collect
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 10),
                        new Text(
                          widget.listModel.author,
                          style: TextStyle(fontSize: 13, color: Colors.black45),
                        ),
                        SizedBox(width: 10),
                        new Text(
                          TimeUtils.getDateTime(widget.listModel.publishTime),
                          style: TextStyle(fontSize: 13, color: Colors.black45),
                        ),
                      ],
                    )
                  ],
                )),
                new Container(
                  width: 72,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 10.0),
                  child: new Image.network(
                    widget.listModel.envelopePic,
                    width: 72,
                    height: 128,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            ),
            decoration: new BoxDecoration(
                color: Colors.white,
                border: new Border(
                    bottom: new BorderSide(width: 0.33, color: Colors.blue)))));
  }

  //收藏按钮
  collect(ProjectListModel model) async {
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
  uncollect(ProjectListModel model) async {
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
