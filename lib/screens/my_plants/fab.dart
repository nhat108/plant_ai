import 'dart:math';

import 'package:flutter/material.dart';

class FABWidget extends StatefulWidget {
  @override
  _FABWidgetState createState() => _FABWidgetState();
}

class _FABWidgetState extends State<FABWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _rotationController;
  bool isRotation = false;
  Animation<double> _animation;
  @override
  void initState() {
    _rotationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      upperBound: pi * 2,
      // value: 1,
    );
    _animation = CurvedAnimation(
      parent: _rotationController,
      curve: Curves.ease,
    );

    super.initState();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(_rotationController),
        child: Icon(Icons.add),
      ),
      onPressed: () {
        if (isRotation) {
          _rotationController.forward();
        } else {
          _rotationController.reset();
        }
        isRotation = !isRotation;
      },
    );
  }
}
