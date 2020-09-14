import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'homeSectionHeader.dart';
import '../model/homeRecoReposModel.dart';

//wx articals
// ignore: must_be_immutable
class WXArticalSection extends StatelessWidget {
  HomeRecoReposModel recoReposModel;
  WXArticalSection(this.recoReposModel);

  List<Widget> _wxArticalsChild() {
    List<Widget> list = [];
    list.add(SectionHeader(
        Icon(Icons.book, color: Colors.green), "WX Articals", Colors.green));

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

//wx cell
// ignore: must_be_immutable
class WXArticalCell extends StatelessWidget {
  RecoReposCellModel cellModel;
  WXArticalCell(this.cellModel);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("wx");
      },
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 2.h, color: Colors.black12),
          ),
        ),
        height: 210.h,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      cellModel.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 80.h,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.favorite,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 16.w),
                        Text(
                          cellModel.author,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(width: 16.w),
                        Text(
                          _dateString(cellModel.niceDate),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.w),
              width: 120.w,
              height: 120.w,
              //color: Colors.orange,
              child: CircleAvatar(
                backgroundColor: Colors.green,
                child: Text(
                  cellModel.superChapterName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//如果日期里返回的是天数，就直接显示，返回的是年-月-日就展示月-日
String _dateString(String date) {
  if (date.contains("天")) {
    return date;
  }
  DateTime x = DateTime.parse(date);
  return "${x.month}-${x.day}";
}
