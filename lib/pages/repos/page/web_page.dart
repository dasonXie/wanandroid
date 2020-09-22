import 'package:flutter/material.dart';
import 'package:wanandroid/pages/repos/widget/like_btn.dart';
import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class WebPage extends StatefulWidget {
  String url;
  String title;
  WebPage(this.url, {this.title, key}) : super(key: key);

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: <Widget>[
          LikeBtn(),
          PopupMenuButton(
            padding: EdgeInsets.all(10),
            onSelected: (value) {
              switch (value) {
                case "browser":
                  launchInBrowser(widget.url, title: widget.title);
                  break;
                case "share":
                  Share.share('${widget.title} : ${widget.url}');
                  break;
                default:
              }
            },
            itemBuilder: (context) {
              return <PopupMenuItem<String>>[
                new PopupMenuItem<String>(
                  value: "browser",
                  child: Row(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                        child: Icon(
                          Icons.language,
                          color: Colors.grey,
                        )),
                    Text("浏览器打开")
                  ]),
                ),
                new PopupMenuItem<String>(
                  value: "share",
                  child: Row(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                        child: Icon(Icons.share, color: Colors.grey)),
                    Text("分享")
                  ]),
                ),
              ];
            },
          )
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        );
      }),
    );
  }
}

Future<Null> launchInBrowser(String url, {String title}) async {
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: false, forceWebView: false);
  } else {
    throw 'Could not launch $url';
  }
}
