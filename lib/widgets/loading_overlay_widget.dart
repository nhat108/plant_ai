import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LoadingOverlayWidget extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  const LoadingOverlayWidget(
      {Key key, @required this.child, this.isLoading = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      child: child,
      isLoading: isLoading,
    );
  }
}
