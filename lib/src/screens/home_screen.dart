import 'package:flutter/material.dart';
import '../screens/helper_classes/cat.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catAnimationController;
  Animation<double> boxAnimation;
  AnimationController boxAnimationController;

  @override
  void initState() {
    super.initState();

    catAnimationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    catAnimation = Tween(begin: -20.0, end: -80.0).animate(
      CurvedAnimation(
        parent: catAnimationController,
        curve: Curves.easeIn,
      ),
    );

    boxAnimationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
      CurvedAnimation(
        parent: boxAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxAnimationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxAnimationController.forward();
      }
    });
    boxAnimationController.forward();
  }

  catOnTap() {
    if (catAnimationController.status == AnimationStatus.completed) {
      boxAnimationController.forward();
      catAnimationController.reverse();
    } else if (catAnimationController.status == AnimationStatus.dismissed) {
      boxAnimationController.stop();
      catAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation"),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap(),
            ],
          ),
        ),
        onTap: catOnTap,
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          right: 0.0,
          left: 0.0,
        );
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Theme.of(context).primaryColor,
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 10.0,
      top: 4.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,
          width: 100.0,
          color: Theme.of(context).primaryColor,
        ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            angle: boxAnimation.value,
            alignment: Alignment.topLeft,
          );
        },
      ),
    );
  }

  Widget buildRightFlap() {
    return Positioned(
      right: 10.0,
      top: 4.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,
          width: 100.0,
          color: Theme.of(context).primaryColor,
        ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            angle: -boxAnimation.value,
            alignment: Alignment.topRight,
          );
        },
      ),
    );
  }
}
