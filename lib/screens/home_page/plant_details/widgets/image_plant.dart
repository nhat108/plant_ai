import 'dart:io';

import 'package:flower/models/plant_model.dart';
import 'package:flower/widgets/cache_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flower/utils/extensions.dart';

class ImagePlant extends StatefulWidget {
  final String imagePath;
  final PlantModel plant;

  const ImagePlant({Key key, @required this.imagePath, @required this.plant})
      : super(key: key);

  @override
  _ImagePlantState createState() => _ImagePlantState();
}

class _ImagePlantState extends State<ImagePlant> {
  var currentImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: -2,
            blurRadius: 17,
            offset: Offset(0, 10), // changes position of shadow
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 23),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            child: currentImage != null || widget.imagePath.isHttp()
                ? CacheImageWidget(
                    imageUrl: currentImage ?? widget.imagePath,
                    height: MediaQuery.of(context).size.width * 0.7,
                    width: double.infinity,
                  )
                : Image.file(
                    File(widget.imagePath),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.7,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 15),
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(widget.plant.images.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (currentImage == widget.plant.images[index]) {
                          currentImage = null;
                        } else {
                          currentImage = widget.plant.images[index];
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CacheImageWidget(
                        imageUrl: '${widget.plant.images[index]}',
                        width: 60,
                        height: 60,
                      ),
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
