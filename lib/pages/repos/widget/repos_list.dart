import 'package:flutter/material.dart';
import 'package:wanandroid/pages/repos/model/projectListModel.dart';
import 'package:wanandroid/pages/repos/page/web_page.dart';
import 'package:wanandroid/pages/time_utils.dart';

import 'like_btn.dart';

class ReposList extends StatelessWidget {
  final ProjectListModel listModel;
  const ReposList(this.listModel, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return WebPage(
                listModel.link,
                title: listModel.title,
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
                    new Text(listModel.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18, color: Colors.black87)),
                    new SizedBox(height: 10),
                    new Expanded(
                      // flex: 1,
                      child: new Text(
                        listModel.desc,
                        maxLines: 3,
                        // softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13, color: Colors.black45),
                      ),
                    ),
                    new SizedBox(height: 10),
                    new Row(
                      children: <Widget>[
                        new LikeBtn(),
                        SizedBox(width: 10),
                        new Text(
                          listModel.author,
                          style: TextStyle(fontSize: 13, color: Colors.black45),
                        ),
                        SizedBox(width: 10),
                        new Text(
                          TimeUtils.getDateTime(listModel.publishTime),
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
                    listModel.envelopePic,
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
}
