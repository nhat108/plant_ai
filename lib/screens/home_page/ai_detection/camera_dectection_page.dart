import 'dart:io';

import 'package:camerawesome/camerapreview.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flower/configs/app_colors.dart';
import 'package:flower/configs/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'choose_related_type.dart';

class CameraDetectionPage extends StatefulWidget {
  CameraDetectionPage();

  @override
  _CameraDetectionPageState createState() => _CameraDetectionPageState();
}

class _CameraDetectionPageState extends State<CameraDetectionPage>
    with TickerProviderStateMixin {
  ValueNotifier<CameraFlashes> _switchFlash = ValueNotifier(CameraFlashes.NONE);
  ValueNotifier<double> _zoomNotifier = ValueNotifier(0);
  ValueNotifier<Size> _photoSize = ValueNotifier(null);
  ValueNotifier<Sensors> _sensor = ValueNotifier(Sensors.BACK);
  ValueNotifier<CaptureModes> _captureMode = ValueNotifier(CaptureModes.PHOTO);
  ValueNotifier<bool> _enableAudio = ValueNotifier(true);

  /// use this to call a take picture
  PictureController _pictureController = new PictureController();

  @override
  void dispose() {
    // previewStreamSub.cancel();
    _photoSize.dispose();
    _captureMode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    child: CameraAwesome(
                      captureMode: _captureMode,
                      photoSize: _photoSize,
                      sensor: _sensor,
                      selectDefaultSize: (availableSizes) => Size.square(800),
                      enableAudio: _enableAudio,
                      switchFlashMode: _switchFlash,
                      zoom: _zoomNotifier,
                      onCameraStarted: () {
                        // camera started here -- do your after start stuff
                      },
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                height: 100,
                child: Center(
                    child: GestureDetector(
                  onTap: () async {
                    final Directory extDir = await getTemporaryDirectory();
                    final testDir = await Directory('${extDir.path}/test')
                        .create(recursive: true);
                    final String filePath =
                        '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
                    await _pictureController.takePicture(filePath);
                    AppRoutes.push(
                        context, ChooseRelatedTypePage(imagePath: filePath));
                  },
                  child: Container(
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.lightColor),
                  ),
                )),
              )
            ],
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.topLeft,
                child: SafeArea(
                  child: Container(
                      margin: EdgeInsets.only(left: 10, top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      width: 30,
                      height: 30,
                      padding: EdgeInsets.all(6),
                      alignment: Alignment.center,
                      child: Center(
                        child: Icon(
                          Icons.clear,
                          size: 18,
                          color: AppColors.primaryColor,
                        ),
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
