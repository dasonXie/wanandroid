import 'package:flutter/material.dart';
import 'recoReposCell.dart';
import 'homeSectionHeader.dart';
import '../model/homeRecoReposModel.dart';

//reco repos
// ignore: must_be_immutable
class RecoReposSection extends StatelessWidget {
  HomeRecoReposModel recoReposModel;
  Function moreOnTap;
  RecoReposSection(this.recoReposModel, {this.moreOnTap});

  List<Widget> _recoReposChild() {
    List<Widget> list = [];
    list.add(
      SectionHeader(
        Icon(
          Icons.book,
          color: Colors.blueAccent,
        ),
        "Reco Repos",
        Colors.blueAccent,
        onTap: moreOnTap,
      ),
    );

    List<RecoReposCellModel> showList = [];
    if (recoReposModel.datas.length > 6) {
      showList = recoReposModel.datas.sublist(0, 6);
    }
    showList.map((e) {
      list.add(RecoReposCell(e));
    }).toList();

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _recoReposChild(),
    );
  }
}
