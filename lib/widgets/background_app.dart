import 'package:flower/configs/assets.dart';
import 'package:flutter/material.dart';

class BackgroundApp extends StatelessWidget {
  final Widget child;
  final double opacity;

  const BackgroundApp({Key key, @required this.child, this.opacity = 0.5})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppAssets.plantBackground,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: new BoxDecoration(
            color: Colors.white.withOpacity(opacity),
          ),
        ),
        child,
      ],
    );
  }
}
