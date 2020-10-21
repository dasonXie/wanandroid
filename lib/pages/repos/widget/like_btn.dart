import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

import 'circle_painter.dart';
import 'dot_painter.dart';
import 'model.dart';

class LikeBtn extends StatefulWidget {
  double width;
  Duration duration;
  LikeIcon icon;
  Color circleStartColor;
  Color circleEndColor;
  DotColor dotColor;

  LikeBtn({
    Key key,
    @required this.width,
    this.icon = const LikeIcon(
      Icons.favorite,
      iconColor: Colors.pinkAccent,
    ),
    this.duration = const Duration(milliseconds: 5000),
    this.dotColor = const DotColor(
      dotPrimaryColor: const Color(0xFFFFC107),
      dotSecondaryColor: const Color(0xFFFF9800),
      dotThirdColor: const Color(0xFFFF5722),
      dotLastColor: const Color(0xFFF44336),
    ),
    this.circleStartColor = const Color(0xFFFF5722),
    this.circleEndColor = const Color(0xFFFFC107),
    // this.onIconClicked,
  }) : super(key: key);

  @override
  _LikeBtnState createState() => _LikeBtnState();
}

class _LikeBtnState extends State<LikeBtn> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> outerCircle;
  Animation<double> innerCircle;
  Animation<double> scale;
  Animation<double> dots;

  bool isLiked = false;
  @override
  void initState() {
    super.initState();
    _animationController =
        new AnimationController(duration: widget.duration, vsync: this);
    _animationController.addListener(() {
      setState(() {});
    });
    _initAllAmimations();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CustomPaint(
          size: Size(widget.width, widget.width),
          painter: DotPainter(
            currentProgress: dots.value,
            color1: widget.dotColor.dotPrimaryColor,
            color2: widget.dotColor.dotSecondaryColor,
            color3: widget.dotColor.dotThirdColorReal,
            color4: widget.dotColor.dotLastColorReal,
          ),
        ),
        CustomPaint(
          size: Size(widget.width * 0.35, widget.width * 0.35),
          painter: CirclePainter(
              innerCircleRadiusProgress: innerCircle.value,
              outerCircleRadiusProgress: outerCircle.value,
              startColor: widget.circleStartColor,
              endColor: widget.circleEndColor),
        ),
        Container(
          width: widget.width,
          height: widget.width,
          alignment: Alignment.center,
          child: Transform.scale(
            scale: isLiked ? scale.value : 1.0,
            child: GestureDetector(
              child: Icon(
                widget.icon.icon,
                color: isLiked ? widget.icon.color : Colors.grey,
                size: widget.width * 0.4,
              ),
              onTap: _onTap,
            ),
          ),
        ),
      ],
    );
  }

  void _onTap() {
    if (_animationController.isAnimating) return;
    isLiked = !isLiked;
    if (isLiked) {
      _animationController.reset();
      _animationController.forward();
    } else {
      setState(() {});
    }
    // if (widget.onIconClicked != null) widget.onIconClicked(isLiked);
  }

  void _initAllAmimations() {
    outerCircle = new Tween<double>(
      begin: 0.1,
      end: 1.0,
    ).animate(
      new CurvedAnimation(
        parent: _animationController,
        curve: new Interval(
          0.0,
          0.3,
          curve: Curves.ease,
        ),
      ),
    );
    innerCircle = new Tween<double>(
      begin: 0.2,
      end: 1.0,
    ).animate(
      new CurvedAnimation(
        parent: _animationController,
        curve: new Interval(
          0.2,
          0.5,
          curve: Curves.ease,
        ),
      ),
    );
    scale = new Tween<double>(
      begin: 0.2,
      end: 1.0,
    ).animate(
      new CurvedAnimation(
        parent: _animationController,
        curve: new Interval(
          0.35,
          0.7,
          curve: OvershootCurve(),
        ),
      ),
    );
    dots = new Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      new CurvedAnimation(
        parent: _animationController,
        curve: new Interval(
          0.1,
          1.0,
          curve: Curves.decelerate,
        ),
      ),
    );
  }
}

class OvershootCurve extends Curve {
  const OvershootCurve([this.period = 2.5]);

  final double period;

  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    t -= 1.0;
    return t * t * ((period + 1) * t + period) + 1.0;
  }

  @override
  String toString() {
    return '$runtimeType($period)';
  }
}
