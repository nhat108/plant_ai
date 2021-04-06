import 'dart:io';

import 'package:flower/widgets/cache_image_widget.dart';
import 'package:flutter/material.dart';

class ImagePlant extends StatelessWidget {
  final String imagePath;

  const ImagePlant({Key key, @required this.imagePath}) : super(key: key);
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
          // Image.file(
          //   File(imagePath),
          //   height: MediaQuery.of(context).size.width * 0.7,
          //   fit: BoxFit.cover,
          // ),
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            child: CacheImageWidget(
              imageUrl:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1NkYHTNSQB-O3iGt7BvA2Q8ECNH7dqU-tKw&usqp=CAU',
              height: MediaQuery.of(context).size.width * 0.7,
              width: double.infinity,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15),
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(6, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CacheImageWidget(
                    imageUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1NkYHTNSQB-O3iGt7BvA2Q8ECNH7dqU-tKw&usqp=CAU',
                    width: 60,
                    height: 60,
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
