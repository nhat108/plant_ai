import 'package:flower/blocs/detect_plant/detect_plant_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'widgets/app_bar.dart';
import 'widgets/list_plant_detected.dart';

class DetectPlantPage extends StatefulWidget {
  final String filePath;

  const DetectPlantPage({Key key, @required this.filePath}) : super(key: key);
  @override
  _DetectPlantPageState createState() => _DetectPlantPageState();
}

class _DetectPlantPageState extends State<DetectPlantPage> {
  final DetectPlantBloc _detectPlantBloc = DetectPlantBloc();
  @override
  void initState() {
    _detectPlantBloc.add(DetectPlant(imagePath: widget.filePath));
    super.initState();
  }

  @override
  void dispose() {
    _detectPlantBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetectPlantBloc, DetectPlantState>(
      cubit: _detectPlantBloc,
      listener: (_, state) {
        if (state.detectPlantError.isNotEmpty) {
          Fluttertoast.showToast(msg: state.detectPlantError);
        }
        if (state.searchPlantError.isNotEmpty) {
          Fluttertoast.showToast(msg: state.searchPlantError);
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            DetectPlantAppBar(imagePath: widget.filePath),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  BlocProvider(
                      create: (_) => _detectPlantBloc,
                      child: ListPlantDetected(
                        imagePath: widget.filePath,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
