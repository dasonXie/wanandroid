import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/homeBannerModel.dart';

// ignore: must_be_immutable
class BannerSwiper extends StatelessWidget {
  List<HomeBannerModel> banners;
  BannerSwiper(this.banners);

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
          return CachedNetworkImage(
            imageUrl: banners[index].imagePath,
            fit: BoxFit.cover,
            placeholder: (context, url) {
              return Center(
                child: SizedBox(
                  width: 50.w,
                  height: 50.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              );
            },
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
