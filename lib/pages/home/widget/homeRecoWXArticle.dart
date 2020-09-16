import 'package:flutter/material.dart';
import 'homeSectionHeader.dart';
import 'wxArticleCell.dart';
import '../model/homeRecoReposModel.dart';

//wx articals
// ignore: must_be_immutable
class WXArticalSection extends StatelessWidget {
  HomeRecoReposModel recoReposModel;
  Function moreOnTap;
  WXArticalSection(this.recoReposModel, {this.moreOnTap});

  List<Widget> _wxArticalsChild() {
    List<Widget> list = [];
    list.add(
      SectionHeader(
        Icon(Icons.book, color: Colors.green),
        "WX Articals",
        Colors.green,
        onTap: moreOnTap,
      ),
    );

    List<RecoReposCellModel> showList = [];
    if (recoReposModel.datas.length > 6) {
      showList = recoReposModel.datas.sublist(0, 6);
    }
    showList.map((e) {
      list.add(WXArticalCell(e));
    }).toList();

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _wxArticalsChild(),
    );
  }
}
