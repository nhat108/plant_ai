import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower/configs/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CacheImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final double borderRadius;

  const CacheImageWidget(
      {Key key,
      @required this.imageUrl,
      @required this.width,
      @required this.height,
      this.borderRadius = 0.0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[200],
            child: SvgPicture.asset(
              AppAssets.leafIcon2,
              fit: BoxFit.fitHeight,
              width: 10,
              height: 10,
            ),
          );
        },
      ),
    );
  }
}
