import 'package:flower/blocs/firestore/firestore_bloc_bloc.dart';
import 'package:flower/configs/app_colors.dart';
import 'package:flower/models/plant_model.dart';
import 'package:flower/screens/home_page/plant_details/widgets/plant_info.dart';
import 'package:flower/widgets/custom_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/image_plant.dart';

class PlantDetailsById extends StatefulWidget {
  final String id;
  final String imagePath;
  final PlantModel plant;

  const PlantDetailsById(
      {Key key,
      @required this.id,
      @required this.imagePath,
      @required this.plant})
      : super(key: key);
  @override
  _PlantDetailsByIdState createState() => _PlantDetailsByIdState();
}

class _PlantDetailsByIdState extends State<PlantDetailsById> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text("${widget.plant.name}"),
        actions: [
          StreamBuilder<bool>(
              stream: BlocProvider.of<FirestoreBlocBloc>(context)
                  .isFavourite(widget.id),
              builder: (context, snapshot) {
                return IconButton(
                    icon: snapshot?.data ?? false
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border),
                    onPressed: () {
                      BlocProvider.of<FirestoreBlocBloc>(context).add(
                          ChangeFavourite(
                              plantId: widget.id, body: widget.plant.toMap()));
                    });
              })
        ],
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper:
                CustomShape(), // this is my own class which extendsCustomClipper
            child: Container(
              height: 150,
              color: AppColors.primaryColor,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  ImagePlant(
                    plant: widget.plant,
                    imagePath: widget.imagePath,
                  ),
                  PlantInfo(
                    plant: widget.plant,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
