import 'package:flower/configs/app_routes.dart';
import 'package:flower/configs/app_styles.dart';
import 'package:flower/screens/my_plants/plant_details/plant_details_page.dart';
import 'package:flower/widgets/cache_image_widget.dart';
import 'package:flutter/material.dart';

class ListMyPlantsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              AppRoutes.push(context, PlantDetailsPage());
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CacheImageWidget(
                    borderRadius: 1000,
                    imageUrl:
                        'https://startupheretoronto.com/wp-content/uploads/2017/01/canadian-maple-leaf.jpg',
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Acer platanoides",
                        style: AppStyles.medium(),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "No reminder",
                        style: AppStyles.light(size: 14),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (_, index) {
          return SizedBox(
            height: 10,
          );
        },
        itemCount: 10,
      ),
    );
  }
}
