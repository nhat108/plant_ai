import 'package:flower/configs/app_colors.dart';
import 'package:flower/configs/app_styles.dart';
import 'package:flower/widgets/cache_image_widget.dart';
import 'package:flutter/material.dart';

class ListPlantDetected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: List.generate(10, (index) {
          return Padding(
            padding:
                const EdgeInsets.only(right: 22, left: 22, top: 20, bottom: 25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rose gallica",
                      style: AppStyles.regular(size: 18),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primaryColor),
                      ),
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.save_alt,
                        color: AppColors.primaryColor,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Genus",
                            style: AppStyles.regular(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Genus",
                            style: AppStyles.regular(),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Family",
                            style: AppStyles.regular(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Rosacea",
                            style: AppStyles.regular(),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Row(
                    children: [
                      Text(
                        "Common names",
                        style: AppStyles.regular(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Hugarian Rose..",
                        style: AppStyles.regular(),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: SingleChildScrollView(
                    child: Row(
                        children: List.generate(4, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CacheImageWidget(
                          imageUrl:
                              'https://www.almanac.com/sites/default/files/image_nodes/rose-peach.jpg',
                          width: 60,
                          height: 60,
                        ),
                      );
                    })),
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
