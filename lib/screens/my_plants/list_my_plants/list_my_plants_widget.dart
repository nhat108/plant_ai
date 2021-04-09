import 'package:flower/blocs/firestore/firestore_bloc_bloc.dart';
import 'package:flower/configs/app_routes.dart';
import 'package:flower/configs/app_styles.dart';
import 'package:flower/models/plant.dart';
import 'package:flower/screens/home_page/detect_plant/widgets/error_widget.dart';
import 'package:flower/screens/home_page/detect_plant/widgets/loading_widget.dart';
import 'package:flower/screens/my_plants/plant_details/plant_details_page.dart';
import 'package:flower/widgets/cache_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListMyPlantsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Plant>>(
        stream:
            BlocProvider.of<FirestoreBlocBloc>(context).getListMyPlantStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: ListView.separated(
                itemBuilder: (_, index) {
                  var plant = snapshot.data[index];
                  return GestureDetector(
                    onTap: () {
                      AppRoutes.push(
                          context,
                          PlantDetailsPage(
                            plant: plant,
                          ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CacheImageWidget(
                            borderRadius: 1000,
                            imageUrl: '${plant.imageUrl}',
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
                                '${plant.commonName}',
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
                itemCount: snapshot.data.length,
              ),
            );
          }
          if (snapshot.hasError) {
            return MyErrorWidget(error: '${snapshot.error.toString()}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingWidget();
          }
          return Container();
        });
  }
}
