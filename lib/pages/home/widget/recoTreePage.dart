import 'package:flutter/material.dart';
import 'recoReposCell.dart';
import '../../../service_method/home/home_network.dart';
import '../model/homeRecoReposModel.dart';

class RecoTreePage extends StatefulWidget {
  int cid;
  RecoTreePage(this.cid, {Key key}) : super(key: key);

  @override
  _RecoTreePageState createState() => _RecoTreePageState();
}

class _RecoTreePageState extends State<RecoTreePage>
    with AutomaticKeepAliveClientMixin {
  List<RecoReposCellModel> _list = [];

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    print("build");
    super.build(context);
    return FutureBuilder(
      future: getReposList(cid: widget.cid),
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
      x.add(RecoReposCell(e));
    }).toList();
    return x;
  }
}
