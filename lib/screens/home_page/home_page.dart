import 'package:flower/configs/app_colors.dart';
import 'package:flower/configs/app_styles.dart';
import 'package:flower/widgets/cache_image_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CacheImageWidget(
          imageUrl:
              'https://caodangyduoctphcm.com.vn/wp-content/uploads/2018/02/dai-hoc-can-tho.jpg',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
                    color: AppColors.lightColor,
                  ),
                ),
                Text(
                  "Identication",
                  style:
                      AppStyles.medium(size: 30, color: AppColors.lightColor),
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
                  Container(
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
                  Container(
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
