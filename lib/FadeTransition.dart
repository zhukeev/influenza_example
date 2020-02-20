import 'package:flutter/material.dart';
import 'dart:math' as math;

class FadeTranslate extends StatefulWidget {
  final Widget child;
  final ValueChanged<AnimationController> animationColtroller;

  FadeTranslate({@required this.child, this.animationColtroller});

  @override
  _FadeTranslateState createState() => _FadeTranslateState();
}

class _FadeTranslateState extends State<FadeTranslate>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> _fadeAnimation;
  Animation<double> _translateAnimation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    widget.animationColtroller(animationController);

//    animationController.addListener(() {print(_translateAnimation.value);});

    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    _translateAnimation =
        Tween(begin: 30.0, end: 0.0).animate(animationController);

    animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
        offset: Offset(0, math.max(0, _translateAnimation.value) ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: widget.child,
        ));
  }
}
