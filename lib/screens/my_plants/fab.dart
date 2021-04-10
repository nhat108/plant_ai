import 'dart:math';

import 'package:flower/configs/app_colors.dart';
import 'package:flower/configs/app_routes.dart';
import 'package:flower/screens/home_page/ai_detection/camera_dectection_page.dart';
import 'package:flower/screens/home_page/ai_detection/choose_related_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:image_picker/image_picker.dart';

class FABWidget extends StatefulWidget {
  @override
  _FABWidgetState createState() => _FABWidgetState();
}

class _FABWidgetState extends State<FABWidget> {
  @override
  Widget build(BuildContext context) {
    return BoomMenu(
      // animatedIcon: AnimatedIcons.menu_close,
      // animatedIconTheme: IconThemeData(size: 22.0),
      child: Icon(Icons.add),

      // scrollVisible: scrollVisible,
      overlayColor: Colors.black,
      fabAlignment: Alignment.center,
      // marginLeft: 0, marginRight: 0,
      // fabPaddingLeft: 0,
      // fabPaddingRight: 0,

      backgroundColor: AppColors.primaryColor,
      overlayOpacity: 0.7,
      children: [
        MenuItem(
          child: Icon(Icons.camera_alt, color: Colors.white),
          title: "Camera",
          titleColor: Colors.white,
          subtitle: "Take a photo",
          subTitleColor: Colors.white,
          backgroundColor: AppColors.lightColor,
          onTap: () async {
            AppRoutes.push(
                context,
                CameraDetectionPage(
                    // cameras: cameras,
                    ),
                isFullScreen: false);
          },
        ),
        MenuItem(
          child: Icon(Icons.album_outlined, color: Colors.white),
          title: "Gallery",
          titleColor: Colors.white,
          subtitle: "Browse your gallery",
          subTitleColor: Colors.white,
          backgroundColor: AppColors.lightColor,
          onTap: () async {
            var image =
                await ImagePicker().getImage(source: ImageSource.gallery);
            AppRoutes.push(
                context,
                ChooseRelatedTypePage(
                  imagePath: image.path,
                ));
          },
        ),
      ],
    );
    // return FloatingActionButton.extended(

    //   child: RotationTransition(
    //     turns: Tween(begin: 0.0, end: 1.0).animate(_rotationController),
    //     child: Icon(Icons.add),
    //   ),
    //   onPressed: () {
    //     if (isRotation) {
    //       _rotationController.forward();
    //     } else {
    //       _rotationController.reset();
    //     }
    //     isRotation = !isRotation;
    //   },
    // );
  }
}
