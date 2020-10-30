import 'package:flutter/material.dart';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

class FijkPage extends StatefulWidget {
  FijkPage({Key key}) : super(key: key);

  @override
  _FijkPageState createState() => _FijkPageState();
}

class _FijkPageState extends State<FijkPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("搜索"),
      ),
      body: VideoScreen(
          url:
              "https://cdn.letv-cdn.com/2018/12/05/JOCeEEUuoteFrjCg/playlist.m3u8"),
    );
  }
}

class VideoScreen extends StatefulWidget {
  final String url;

  VideoScreen({@required this.url});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final FijkPlayer player = FijkPlayer();

  _VideoScreenState();

  @override
  void initState() {
    super.initState();
    player.setDataSource(widget.url, autoPlay: true);
    player.seekTo(233956);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fijkplayer Example1")),
      body: Container(
        alignment: Alignment.center,
        child: FijkView(
          player: player,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await player.seekTo(333956);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }
}
