import 'package:flower/blocs/plant_details/plant_details_bloc.dart';
import 'package:flower/configs/app_colors.dart';
import 'package:flower/configs/app_styles.dart';
import 'package:flower/screens/home_page/detect_plant/widgets/error_widget.dart';
import 'package:flower/screens/home_page/detect_plant/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlantInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantDetailsBloc, PlantDetailsState>(
        builder: (context, state) {
      if (state.getPlantDetailsLoading) {
        return LoadingWidget(
          height: 200,
        );
      }
      if (state.getPlantDetailsError.isNotEmpty) {
        return MyErrorWidget(error: state.getPlantDetailsError);
      }
      if (state.plantDetails != null) {
        return Container(
          margin: EdgeInsets.only(top: 20, right: 23, left: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${state.plantDetails.commonName ?? 'Unknow'}",
                      style: AppStyles.medium(size: 22),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "GENUS",
                              style: AppStyles.regular(
                                size: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Sanservieria",
                              style: AppStyles.regular(
                                size: 16,
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "FAMILY",
                              style: AppStyles.regular(
                                size: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Asparageceae",
                              style: AppStyles.regular(
                                size: 16,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "DESCRIPTION",
                style: AppStyles.regular(
                  size: 16,
                ),
              ),
            ],
          ),
        );
      }
      return Container();
    });
  }
}
