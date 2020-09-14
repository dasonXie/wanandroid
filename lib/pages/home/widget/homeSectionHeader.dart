import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//header
// ignore: must_be_immutable
class SectionHeader extends StatelessWidget {
  Icon icon;
  String title;
  Function onTap;
  Color color;
  SectionHeader(this.icon, this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      height: 100.h,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 30.w),
            child: icon,
          ),
          SizedBox(
            width: 20.w,
          ),
          Text(
            title,
            style: TextStyle(color: color),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 30.w),
              child: InkWell(
                onTap: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text("More", style: TextStyle(color: Colors.grey)),
                    Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
