import 'package:flutter/material.dart';

import 'widgets/app_bar.dart';
import 'widgets/list_plant_detected.dart';

class DetectPlantPage extends StatefulWidget {
  final String filePath;

  const DetectPlantPage({Key key, @required this.filePath}) : super(key: key);
  @override
  _DetectPlantPageState createState() => _DetectPlantPageState();
}

class _DetectPlantPageState extends State<DetectPlantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
      ),
      body: CustomScrollView(
        slivers: [
          DetectPlantAppBar(imagePath: widget.filePath),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ListPlantDetected(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
