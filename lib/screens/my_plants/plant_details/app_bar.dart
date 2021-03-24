import 'package:flower/configs/app_colors.dart';
import 'package:flower/configs/app_styles.dart';
import 'package:flower/widgets/cache_image_widget.dart';
import 'package:flutter/material.dart';

class PlantDetailsAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.primaryColor,
      pinned: true,
      snap: false,

      // floating: _floating,
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('Acer plantanoides'),
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
                  child: CacheImageWidget(
                    width: double.infinity,
                    height: 200,
                    imageUrl:
                        'https://cdn.plant-for-the-planet.org/media/images/app/bg_layer.jpg',
                  ),
                ),
              ),
              Positioned(
                bottom: 18,
                right: 22,
                left: 22,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Text(
                        "Acer plantanoides",
                        style: AppStyles.medium(size: 20),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.info,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () {})
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
