import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../model/homeRecoReposModel.dart';

//reco cell
// ignore: must_be_immutable
class RecoReposCell extends StatelessWidget {
  RecoReposCellModel cellModel;
  RecoReposCell(this.cellModel);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("item");
      },
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 2.h, color: Colors.black12),
          ),
        ),
        height: 290.h,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 44.h,
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
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Text(
                        cellModel.desc,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 28.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 44.h,
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
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.w),
              width: 160.w,
              //color: Colors.orange,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: cellModel.envelopePic,
                placeholder: (context, url) {
                  return Container(
                    width: 160.w,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Icon(Icons.error, color: Colors.grey);
                },
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
