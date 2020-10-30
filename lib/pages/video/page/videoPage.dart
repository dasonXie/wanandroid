import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_getuuid/flutter_getuuid.dart';
import 'package:video_player/video_player.dart';
import 'package:wanandroid/pages/video/widget/videoControls.dart';
import 'package:wanandroid/pages/video/widget/videoProgress.dart';

class VideoPage extends StatefulWidget {
  VideoPage({Key key}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(
        'https://cdn.letv-cdn.com/2018/12/05/JOCeEEUuoteFrjCg/playlist.m3u8');
    _videoPlayerController2 = VideoPlayerController.network(
        'http://cctvalih5ca.v.myalicdn.com/live/cctv1_2/index.m3u8');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 16 / 9,
//      autoPlay: true,
//      autoInitialize: true,

      looping: true,
//      startAt: Duration(seconds: 10),
      placeholder: Container(
        color: Colors.blue,
        child: Expanded(child: Image.network("https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1756691031,1153417029&fm=26&gp=0.jpg",
          fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity)),
      ),

      // Try playing around with some of these other options:

      showControls: true,
      customControls: VideoControls(
        backgroundColor: Colors.transparent,
        iconColor: Color.fromARGB(255, 200, 200, 200),
//        cutTimeSeconds: 15,
        onTimes: (value){
          if (value >= Duration(seconds: 15)) {
            print("新的回调"+value.toString());
            _chewieController.pause();
            return false;
          }
          return true;
        },
      ),

//
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
    );
  }
  static netFetch() async {
    /// 获取手机的UUID
   String uuid = await FlutterGetuuid.platformUid;

   if(Platform.isIOS){
     print("IOS");
     //ios相关代码
   } else if (Platform.isAndroid) {
     print("安卓");
     //android相关代码
   }
   print("我是uuid: "+uuid);
    /// 获取手机的型号如“iPhone7”
    String phoneMark = await FlutterGetuuid.platformDeviceModle;
   print("我是phoneMark: "+phoneMark);
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("视频"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Chewie(
                controller: _chewieController,
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              _chewieController.enterFullScreen();
            },
            child: Text('Fullscreen'),
          ),FlatButton(
            onPressed: () {
              _videoPlayerController1.initialize();
              _chewieController.play();
              netFetch();
            },
            child: Text('start'),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _chewieController.dispose();
                      _videoPlayerController1.pause();
                      _videoPlayerController1.seekTo(Duration(seconds: 120));
                      _chewieController = ChewieController(
                        videoPlayerController: _videoPlayerController1,
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        looping: true,
                        placeholder: Container(
                          child: Image.network("https://img-bss.csdn.net/1603119499185.jpg",
                            fit: BoxFit.fill,),
                        ),
                      );
                    });
                  },
                  child: Padding(
                    child: Text("Video 1"),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                ),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _chewieController.dispose();
                      _videoPlayerController1.pause();
                      _videoPlayerController1.seekTo(Duration(seconds: 30));
                      _chewieController = ChewieController(
                        videoPlayerController: _videoPlayerController2,
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        looping: true,
                        isLive: true,
                      );
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text("Error Video"),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Padding(
                    child: Text("Android controls"),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                ),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text("iOS controls"),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
