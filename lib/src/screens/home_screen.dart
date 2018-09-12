import 'package:flutter/material.dart';
import '../screens/helper_classes/cat.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catAnimationController;

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
  }

  catOnTap() {
    if (catAnimationController.status == AnimationStatus.completed) {
      catAnimationController.reverse();
    } else if (catAnimationController.status == AnimationStatus.dismissed) {
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
}
