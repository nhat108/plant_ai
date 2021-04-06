import 'package:flower/blocs/plant_details/plant_details_bloc.dart';
import 'package:flower/configs/app_colors.dart';
import 'package:flower/screens/home_page/plant_details/widgets/plant_info.dart';
import 'package:flower/widgets/custom_shape.dart';
import 'package:flutter/material.dart';

import 'widgets/image_plant.dart';

class PlantDetailsById extends StatefulWidget {
  final String id;
  final String imagePath;

  const PlantDetailsById({Key key, @required this.id, @required this.imagePath})
      : super(key: key);
  @override
  _PlantDetailsByIdState createState() => _PlantDetailsByIdState();
}

class _PlantDetailsByIdState extends State<PlantDetailsById> {
  final PlantDetailsBloc _plantDetailsBloc = PlantDetailsBloc();
  @override
  void initState() {
    _plantDetailsBloc.add(
      GetPlantDetailsById(
        id: widget.id,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text("Name"),
        actions: [
          IconButton(icon: Icon(Icons.favorite_border), onPressed: () {})
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
                    imagePath: widget.imagePath,
                  ),
                  PlantInfo(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
