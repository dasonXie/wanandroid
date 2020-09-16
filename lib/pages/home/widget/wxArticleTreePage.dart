import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'wxArticleCell.dart';
import '../../../service_method/home/home_network.dart';
import '../model/homeRecoReposModel.dart';

// ignore: must_be_immutable
class WXArticleTreePage extends StatefulWidget {
  int chapterId;
  WXArticleTreePage(this.chapterId, {Key key}) : super(key: key);

  @override
  _WXArticleTreePageState createState() => _WXArticleTreePageState();
}

class _WXArticleTreePageState extends State<WXArticleTreePage>
    with AutomaticKeepAliveClientMixin {
  List<RecoReposCellModel> _list = [];
  int _currentPage;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _currentPage = 1;
    loadPageData();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    super.build(context);
    return _list.length == 0
        ? Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
        : refreshWidget();
  }

  Widget refreshWidget() {
    return EasyRefresh(
      header: PhoenixHeader(),
      onRefresh: () async {
        _currentPage = 1;
        loadPageData();
      },
      footer: PhoenixFooter(),
      onLoad: () async {
        _currentPage++;
        loadPageData();
      },
      child: ListView(
        children: columnChild(),
      ),
    );
  }

  Future loadPageData() async {
    await getWXArticalList(chapterId: widget.chapterId, page: _currentPage)
        .then((value) {
      if (_currentPage == 1) {
        _list = [];
      }
      HomeRecoReposModel model = HomeRecoReposModel.fromJson(value["data"]);
      model.datas.map((e) {
        _list.add(e);
      }).toList();
      setState(() {});
    });
  }

  List<Widget> columnChild() {
    List<Widget> x = [];
    _list.map((e) {
      x.add(WXArticalCell(e));
    }).toList();
    return x;
  }
}
