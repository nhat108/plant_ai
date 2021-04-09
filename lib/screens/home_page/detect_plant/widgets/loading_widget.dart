import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final double height;

  const LoadingWidget({Key key, this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
      height: height ?? MediaQuery.of(context).size.height,
    );
  }
}
