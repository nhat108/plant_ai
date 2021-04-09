import 'package:flower/blocs/detect_plant/detect_plant_bloc.dart';
import 'package:flower/blocs/firestore/firestore_bloc_bloc.dart';
import 'package:flower/configs/app_colors.dart';
import 'package:flower/configs/app_routes.dart';
import 'package:flower/configs/app_styles.dart';
import 'package:flower/screens/home_page/detect_plant/widgets/empty_widget.dart';
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
      if (state.detectPlantLoading == false &&
          state.searchPlantLoading == false &&
          state.listPlants.isEmpty) {
        return EmptyWidget();
      }
      if (state.listPlants.isNotEmpty) {
        return Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            children: List.generate(state.listPlants.length, (index) {
              var plant = state.listPlants[index];
              return GestureDetector(
                onTap: () {
                  AppRoutes.push(
                      context,
                      PlantDetailsById(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            plant.commonName ?? "Unknow",
                            style: AppStyles.regular(size: 18),
                          ),
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<FirestoreBlocBloc>(context).add(
                                  SavePlant(
                                      id: plant.id.toString(),
                                      body: plant.toMap()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: AppColors.primaryColor),
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
                              "Common names",
                              style: AppStyles.regular(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                "${plant.synonyms.isEmpty ? '' : plant.synonyms.reduce((value, element) => value + ', ' + element)}",
                                style: AppStyles.regular(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        // child: SingleChildScrollView(
                        //   child: Row(
                        //       children: List.generate(4, (index) {
                        //     return Padding(
                        //       padding: const EdgeInsets.only(right: 10),
                        //       child: CacheImageWidget(
                        //         imageUrl:
                        //             'https://www.almanac.com/sites/default/files/image_nodes/rose-peach.jpg',
                        //         width: 60,
                        //         height: 60,
                        //       ),
                        //     );
                        //   })),
                        // ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: CacheImageWidget(
                              imageUrl: '${plant.imageUrl}',
                              width: 60,
                              height: 60),
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
      return Container();
    });
  }
}
