import 'package:flower/blocs/firestore/firestore_bloc_bloc.dart';
import 'package:flower/configs/app_colors.dart';
import 'package:flower/configs/app_styles.dart';
import 'package:flower/models/plant_model.dart';
import 'package:flower/widgets/cache_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentSnapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PlantModel>>(
        stream: BlocProvider.of<FirestoreBlocBloc>(context).getListRecentSnap(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                itemBuilder: (_, index) {
                  var plant = snapshot.data[index];
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        CacheImageWidget(
                          borderRadius: 1000,
                          imageUrl: plant.images.first,
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text(
                          "${plant.name ?? 'Unknow'}",
                          style: AppStyles.medium(size: 16),
                        )),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<FirestoreBlocBloc>(context).add(
                              MoveRecentSnapToMyPlant(
                                plantId: plant.id.toString(),
                                body: plant.toMap(),
                              ),
                            );
                          },
                          child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.primaryColor,
                              ),
                              child: Icon(Icons.add, color: Colors.white)),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(
                      height: 20,
                    ),
                itemCount: snapshot.data.length);
          }
          return Container();
        });
  }
}
