import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wanandroid/model/homeRecoReposModel.dart';
import '../service_method/home_network.dart';
import '../model/baseModel.dart';
import '../model/homeBannerModel.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  var _futureBuilderFuture;
  ScrollController _scrollC = ScrollController();
  bool _showTopBtn = false;

  @override
  void initState() {
    super.initState();

    _futureBuilderFuture = _getHomeDatas();

    _scrollC.addListener(() {
      if (_scrollC.offset >= 400 && _showTopBtn == false) {
        setState(() {
          _showTopBtn = true;
        });
      } else if (_scrollC.offset < 400 && _showTopBtn == true) {
        setState(() {
          _showTopBtn = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _futureBuilderFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var list = snapshot.data as List;
            //banner数据
            var bannerRes = list[0];
            var banners = BaseRespList<HomeBannerModel>(
                bannerRes, (bannerRes) => HomeBannerModel.fromJson(bannerRes));
            //reco repos数据
            var recoRepos = list[1];
            HomeRecoReposModel recoReposModel =
                HomeRecoReposModel.fromJson(recoRepos["data"]);
            //wx artical数据
            var wxArtical = list[2];
            HomeRecoReposModel wxArticalModel =
                HomeRecoReposModel.fromJson(wxArtical["data"]);

            return ListView(
              controller: _scrollC,
              children: <Widget>[
                Banner(banners.data),
                RecoRepos(recoReposModel),
                WXArticals(wxArticalModel),
              ],
            );
          } else {
            return Container(
              padding: EdgeInsets.only(top: 20.h),
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 60.w,
                height: 60.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: !_showTopBtn
          ? null
          : FloatingActionButton(
              onPressed: () {
                _scrollC.animateTo(.0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              },
              backgroundColor: Colors.purple,
              child: Icon(Icons.keyboard_arrow_up),
            ),
    );
  }
}

//网络请求
Future _getHomeDatas() async {
  return Future.wait([getBanner(), getReposList(), getWXArticalList()]);
}

//轮播图
class Banner extends StatelessWidget {
  List<HomeBannerModel> banners;
  Banner(this.banners);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.wp,
      height: 420.h,
      color: Colors.grey,
      child: Swiper(
        itemCount: banners.length,
        autoplay: true,
        pagination: BannerPagination(),
        itemBuilder: (context, index) {
          return Image.network(
            banners[index].imagePath,
            fit: BoxFit.cover,
          );
        },
        onTap: (index) {
          print(banners[index].url);
        },
      ),
    );
  }
}

//指示器
class BannerPagination extends SwiperPlugin {
  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    return Container(
      width: 60.w,
      height: 40.w,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10.h, left: 1.wp - 70.w),
      decoration: BoxDecoration(
          color: Colors.black54, borderRadius: BorderRadius.circular(20.w)),
      child: Text(
        "${config.activeIndex + 1}/${config.itemCount}",
        style: TextStyle(
          color: Colors.white,
          fontSize: 22.sp,
        ),
      ),
    );
  }
}

//reco repos
class RecoRepos extends StatelessWidget {
  HomeRecoReposModel recoReposModel;
  RecoRepos(this.recoReposModel);

  List<Widget> _recoReposChild() {
    List<Widget> list = [];
    list.add(Header(Icon(Icons.book, color: Colors.blueAccent), "Reco Repos",
        Colors.blueAccent));

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

//wx articals
class WXArticals extends StatelessWidget {
  HomeRecoReposModel recoReposModel;
  WXArticals(this.recoReposModel);

  List<Widget> _wxArticalsChild() {
    List<Widget> list = [];
    list.add(Header(
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

//header
class Header extends StatelessWidget {
  Icon icon;
  String title;
  Function onTap;
  Color color;
  Header(this.icon, this.title, this.color);

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

//reco cell
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
                  Text(
                    cellModel.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    cellModel.desc,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 28.sp,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
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

//wx cell
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
