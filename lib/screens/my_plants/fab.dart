import 'package:flower/configs/app_colors.dart';
import 'package:flower/configs/app_routes.dart';
import 'package:flower/screens/home_page/ai_detection/camera_dectection_page.dart';
import 'package:flower/screens/home_page/detect_plant/detect_plant_page.dart';
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
      child: Icon(Icons.add),
      overlayColor: Colors.black,
      fabAlignment: Alignment.center,
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
            AppRoutes.push(context, DetectPlantPage(filePath: image.path));
          },
        ),
      ],
    );
  }
}
