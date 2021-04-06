import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  final String error;

  const MyErrorWidget({Key key, @required this.error}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Text('$error'),
      ),
    );
  }
}
