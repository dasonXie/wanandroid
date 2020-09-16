import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid/pages/home/widget/homeRecoRepos.dart';
import 'package:wanandroid/pages/home/widget/homeRecoWXArticle.dart';
import '../widget/homeBanner.dart';
import '../model/homeBannerModel.dart';
import '../model/homeRecoReposModel.dart';
import 'package:wanandroid/service_method/home/home_network.dart';
import 'package:wanandroid/model/baseModel.dart';
import 'home_repostree_page.dart';

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
                BannerSwiper(banners.data),
                RecoReposSection(
                  recoReposModel,
                  moreOnTap: () {
                    _moreTreesPage(Treetype.recorepos, context);
                  },
                ),
                WXArticalSection(
                  wxArticalModel,
                  moreOnTap: () {
                    _moreTreesPage(Treetype.wxarticles, context);
                  },
                ),
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

  //更多
  _moreTreesPage(Treetype type, BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(
      builder: (context) {
        return ReposTree(type);
      },
    ));
  }
}

//网络请求
Future _getHomeDatas() async {
  return Future.wait([getBanner(), getReposList(), getWXArticalList()]);
}
