import 'package:flower/blocs/firestore/firestore_bloc_bloc.dart';
import 'package:flower/configs/app_colors.dart';
import 'package:flower/configs/app_routes.dart';
import 'package:flower/configs/app_styles.dart';
import 'package:flower/models/note.dart';
import 'package:flower/models/plant.dart';
import 'package:flower/screens/home_page/detect_plant/widgets/error_widget.dart';
import 'package:flower/screens/home_page/detect_plant/widgets/loading_widget.dart';
import 'package:flower/screens/my_plants/plant_details/notes/add_note_page.dart';
import 'package:flower/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListNotesPage extends StatelessWidget {
  final Plant plant;

  const ListNotesPage({Key key, @required this.plant}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          AppRoutes.push(
              context,
              AddNotePage(
                plant: plant,
              ));
        },
        label: Row(
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              "Note",
              style: AppStyles.medium(),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Timeline",
                style:
                    AppStyles.medium(size: 18, color: AppColors.primaryColor),
              ),
              Divider(
                height: 35,
              ),
              StreamBuilder<List<Note>>(
                  stream: BlocProvider.of<FirestoreBlocBloc>(context)
                      .getListNotes(plant.id.toString()),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LoadingWidget();
                    }
                    if (snapshot.hasError) {
                      return MyErrorWidget(error: snapshot.error);
                    }
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: snapshot.data.map((e) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.orange[100].withOpacity(0.5),
                                  ),
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        color: Colors.orange,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${Helper.formatDateTime(e.date, 'MMM d, yyyy')}",
                                        style: AppStyles.medium(
                                          size: 18,
                                          color: Colors.orange,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${Helper.formatDateTime(e.date, 'hh:mm a')}",
                                  style: AppStyles.medium(size: 16),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "${e.note}",
                                  style: AppStyles.light(size: 16),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    }
                    return Container();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
