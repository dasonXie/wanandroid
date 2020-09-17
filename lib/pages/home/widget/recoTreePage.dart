import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'recoReposCell.dart';
import '../../../service_method/home/home_network.dart';
import '../model/homeRecoReposModel.dart';

// ignore: must_be_immutable
class RecoTreePage extends StatefulWidget {
  int cid;
  RecoTreePage(this.cid, {Key key}) : super(key: key);

  @override
  _RecoTreePageState createState() => _RecoTreePageState();
}

class _RecoTreePageState extends State<RecoTreePage>
    with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController;
  bool _showTopBtn = false;
  List<RecoReposCellModel> _list = [];
  int _currentPage;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset >= 400 && _showTopBtn == false) {
        setState(() {
          _showTopBtn = true;
        });
      } else if (_scrollController.offset < 400 && _showTopBtn == true) {
        setState(() {
          _showTopBtn = false;
        });
      }
    });
    _currentPage = 1;
    loadPageData();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    print("build");
    super.build(context);
    return Scaffold(
      body: _list.length == 0
          ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : refreshWidget(),
      floatingActionButton: _showTopBtn
          ? FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(.0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              },
              child: Icon(
                Icons.arrow_upward,
              ),
              backgroundColor: Colors.purple,
            )
          : null,
    );
  }

  Widget refreshWidget() {
    return EasyRefresh(
      header: TaurusHeader(),
      onRefresh: () async {
        _currentPage = 1;
        loadPageData();
      },
      footer: TaurusFooter(),
      onLoad: () async {
        _currentPage++;
        loadPageData();
      },
      child: ListView(
        controller: _scrollController,
        children: columnChild(),
      ),
    );
  }

  Future loadPageData() async {
    await getReposList(cid: widget.cid, page: _currentPage).then((value) {
      if (_currentPage == 1) {
        _list = [];
      }
      HomeRecoReposModel model = HomeRecoReposModel.fromJson(value["data"]);
      model.datas.map((e) {
        _list.add(e);
      }).toList();
      if (mounted) {
        setState(() {});
      }
    });
  }

  List<Widget> columnChild() {
    List<Widget> x = [];
    _list.map((e) {
      x.add(RecoReposCell(e));
    }).toList();
    return x;
  }
}
