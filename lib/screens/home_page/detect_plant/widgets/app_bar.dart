import 'dart:io';

import 'package:flower/configs/app_colors.dart';
import 'package:flutter/material.dart';

class DetectPlantAppBar extends StatelessWidget {
  final String imagePath;

  const DetectPlantAppBar({Key key, @required this.imagePath})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.primaryColor,
      pinned: true,
      snap: false,
      expandedHeight: 200.0,
      title: Text(
        "Results",
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          height: 200,
          color: Colors.white,
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
