import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressDialogPrimary extends StatefulWidget {
    const ProgressDialogPrimary({Key? key}) : super(key: key);

  @override
  ProgressDialogPrimaryState createState() => ProgressDialogPrimaryState();
}

class ProgressDialogPrimaryState extends State<ProgressDialogPrimary>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
  }

  @override
  dispose() {
    _controller!.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.white,
          Colors.blue,
        ],
      )),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: AnimatedBuilder(
                  animation: _controller!,
                  builder: (_, child) {
                    return Transform.rotate(
                      angle: _controller!.value * 2 * 3.14,
                      child: child,
                    );
                  },
                  child: const Image(
                    image: AssetImage("assets/images/sunny.png"),
                    width: 100, height: 100,
                    //  fit: BoxFit.contain,
                  )),
            ),
          ],
        ),
      ),
      // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
    ));
  }
}
