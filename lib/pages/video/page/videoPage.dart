import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
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
        'http://9890.vod.myqcloud.com/9890_4e292f9a3dd011e6b4078980237cc3d3.f20.mp4');
    _videoPlayerController2 = VideoPlayerController.network(
        'http://9890.vod.myqcloud.com/9890_4e292f9a3dd011e6b4078980237cc3d3.f20.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: true,
      startAt: Duration(seconds: 10),

      // Try playing around with some of these other options:

      showControls: true,
      customControls: VideoControls(
        backgroundColor: Colors.transparent,
        iconColor: Color.fromARGB(255, 200, 200, 200),
        cutTimeSeconds: 15,
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
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _chewieController.dispose();
                      _videoPlayerController2.pause();
                      _videoPlayerController2.seekTo(Duration(seconds: 20));
                      _chewieController = ChewieController(
                        videoPlayerController: _videoPlayerController1,
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        looping: true,
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
