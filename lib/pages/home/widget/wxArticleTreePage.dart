import 'package:flutter/material.dart';
import 'wxArticleCell.dart';
import '../../../service_method/home/home_network.dart';
import '../model/homeRecoReposModel.dart';

class WXArticleTreePage extends StatefulWidget {
  int chapterId;
  WXArticleTreePage(this.chapterId, {Key key}) : super(key: key);

  @override
  _WXArticleTreePageState createState() => _WXArticleTreePageState();
}

class _WXArticleTreePageState extends State<WXArticleTreePage>
    with AutomaticKeepAliveClientMixin {
  List<RecoReposCellModel> _list = [];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    print("build");
    super.build(context);
    return FutureBuilder(
      future: getWXArticalList(chapterId: widget.chapterId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var x = snapshot.data as Map;
          HomeRecoReposModel model = HomeRecoReposModel.fromJson(x["data"]);
          model.datas.map((e) {
            _list.add(e);
          }).toList();

          return _detaiList();
        } else {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        }
      },
    );
  }

  Widget _detaiList() {
    return ListView(
      children: _columnChild(),
    );
  }

  List<Widget> _columnChild() {
    List<Widget> x = [];
    _list.map((e) {
      x.add(WXArticalCell(e));
    }).toList();
    return x;
  }
}
