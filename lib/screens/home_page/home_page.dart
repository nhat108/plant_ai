import 'package:flower/configs/app_colors.dart';
import 'package:flower/configs/app_routes.dart';
import 'package:flower/configs/app_styles.dart';
import 'package:flower/screens/home_page/ai_detection/camera_dectection_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'ai_detection/choose_related_type.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.primaryColor,
        ),
        Positioned(
          left: 20,
          top: 20,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Plant",
                  style: AppStyles.black(
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Identication",
                  style: AppStyles.medium(size: 30, color: Colors.white),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 200),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 10,
                blurRadius: 30,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      AppRoutes.push(
                          context,
                          CameraDetectionPage(
                              // cameras: cameras,
                              ),
                          isFullScreen: false);
                    },
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                      ),
                      child: Icon(
                        Icons.camera,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Take Photo",
                    style: AppStyles.medium(
                        size: 20, color: AppColors.primaryColor),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      // AppRoutes.push(
                      //     context,
                      //     PlantDetailsById(
                      //       id: '118155',
                      //       imagePath: '',
                      //     ));
                      var image = await ImagePicker()
                          .getImage(source: ImageSource.gallery);
                      AppRoutes.push(
                          context,
                          ChooseRelatedTypePage(
                            imagePath: image.path,
                          ));
                    },
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                      ),
                      child: Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Gallery",
                    style: AppStyles.medium(
                        size: 20, color: AppColors.primaryColor),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
