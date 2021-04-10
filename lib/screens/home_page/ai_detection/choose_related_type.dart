import 'package:flower/configs/app_colors.dart';
import 'package:flower/configs/app_routes.dart';
import 'package:flower/configs/app_styles.dart';
import 'package:flower/configs/assets.dart';
import 'package:flower/screens/home_page/detect_plant/detect_plant_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChooseRelatedTypePage extends StatelessWidget {
  final String imagePath;

  const ChooseRelatedTypePage({Key key, @required this.imagePath})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Choose related type",
          style: TextStyle(color: AppColors.primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23, vertical: 10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  AppRoutes.push(
                      context,
                      DetectPlantPage(
                        filePath: imagePath,
                      ));
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightGreenAccent[100].withOpacity(0.5),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.asset(
                              AppAssets.leafBackground,
                              fit: BoxFit.cover,
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          Container(
                            height: 100,
                            padding: EdgeInsets.only(top: 20),
                            alignment: Alignment.center,
                            child: Text(
                              "Leaf",
                              style: AppStyles.medium(size: 22),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(20),
                          child: SvgPicture.asset(
                            AppAssets.leafIcon,
                            width: 45,
                            height: 45,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.redAccent[100],
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: Image.asset(
                            AppAssets.flowerBackground,
                            fit: BoxFit.cover,
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                        Container(
                          height: 100,
                          padding: EdgeInsets.only(top: 20),
                          alignment: Alignment.center,
                          child: Text(
                            "Flower",
                            style: AppStyles.medium(size: 22),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(20),
                        child: SvgPicture.asset(
                          AppAssets.flowerIcon,
                          width: 45,
                          height: 45,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
