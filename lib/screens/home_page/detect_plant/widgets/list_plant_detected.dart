import 'package:flower/blocs/detect_plant/detect_plant_bloc.dart';
import 'package:flower/blocs/firestore/firestore_bloc_bloc.dart';
import 'package:flower/configs/app_colors.dart';
import 'package:flower/configs/app_routes.dart';
import 'package:flower/configs/app_styles.dart';
import 'package:flower/models/plant_model.dart';
import 'package:flower/screens/home_page/detect_plant/widgets/error_widget.dart';
import 'package:flower/screens/home_page/detect_plant/widgets/loading_widget.dart';
import 'package:flower/screens/home_page/plant_details/plant_details_page.dart';
import 'package:flower/widgets/cache_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListPlantDetected extends StatelessWidget {
  final String imagePath;

  const ListPlantDetected({Key key, @required this.imagePath})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetectPlantBloc, DetectPlantState>(
        builder: (context, state) {
      if (state.detectPlantLoading || state.searchPlantLoading) {
        return LoadingWidget();
      }
      if (state.detectPlantError.isNotEmpty) {
        return MyErrorWidget(error: state.detectPlantError);
      }
      if (state.searchPlantError.isNotEmpty) {
        return MyErrorWidget(error: state.searchPlantError);
      }

      if (state.recogitions.isNotEmpty) {
        return StreamBuilder<List<PlantModel>>(
            stream:
                BlocProvider.of<FirestoreBlocBloc>(context).getListPlantModel(
              ids: state.recogitions.map((e) => e.detectedClass).toList(),
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: List.generate(snapshot.data.length, (index) {
                      var plant = snapshot.data[index];
                      return GestureDetector(
                        onTap: () {
                          BlocProvider.of<FirestoreBlocBloc>(context).add(
                              AddToRecentSnap(
                                  body: plant.toMap(),
                                  plantId: plant.id.toString()));
                          AppRoutes.push(
                              context,
                              PlantDetailsById(
                                plant: plant,
                                id: plant.id.toString(),
                                imagePath: imagePath,
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 22, left: 22, top: 20, bottom: 25),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    plant.name ?? "Unknow",
                                    style: AppStyles.regular(size: 18),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<FirestoreBlocBloc>(
                                              context)
                                          .add(SavePlant(
                                              id: plant.id.toString(),
                                              body: plant.toMap()));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: AppColors.primaryColor),
                                      ),
                                      padding: EdgeInsets.all(5),
                                      child: Icon(
                                        Icons.save_alt,
                                        color: AppColors.primaryColor,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          "${plant.genus}",
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
                                          "${plant.family}",
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Images",
                                      style: AppStyles.regular(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    // Expanded(
                                    //   child: Text(
                                    //     "${plant.}",
                                    //     style: AppStyles.regular(),
                                    //     maxLines: 2,
                                    //     overflow: TextOverflow.ellipsis,
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      children: List.generate(
                                          plant.images.length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: CacheImageWidget(
                                        imageUrl: '${plant.images[index]}',
                                        width: 60,
                                        height: 60,
                                      ),
                                    );
                                  })),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingWidget();
              }
              if (snapshot.hasError) {
                return MyErrorWidget(error: snapshot.error.toString());
              }
              return Container();
            });
      }
      return Container();
    });
  }
}
