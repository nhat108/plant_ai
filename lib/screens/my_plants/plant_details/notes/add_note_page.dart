import 'dart:io';

import 'package:flower/blocs/firestore/firestore_bloc_bloc.dart';
import 'package:flower/configs/app_colors.dart';
import 'package:flower/configs/app_styles.dart';
import 'package:flower/models/plant_model.dart';
import 'package:flower/utils/custom_dialog.dart';
import 'package:flower/widgets/background_app.dart';
import 'package:flower/widgets/loading_overlay_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddNotePage extends StatefulWidget {
  final PlantModel plant;

  const AddNotePage({Key key, @required this.plant}) : super(key: key);
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  var now = DateTime.now();
  List<File> images = [];
  @override
  void initState() {
    _nameController.text = widget.plant.name;

    _dateController.text = DateFormat.yMMMMd('en_US').format(now);
    _timeController.text = DateFormat.jm().format(now);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FirestoreBlocBloc, FirestoreBlocState>(
      listener: (_, state) {
        if (state.saveNoteError.isNotEmpty) {
          CustomDialog.showError(context, message: state.saveNoteError);
        }
        if (state.saveNoteSuccess) {
          CustomDialog.showInfo(context, message: "Success", onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          });
        }
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            BlocProvider.of<FirestoreBlocBloc>(context).add(
              SaveNote(
                plantId: widget.plant.id.toString(),
                body: {
                  'name': widget.plant.name,
                  'date': now.toIso8601String(),
                  'note': _noteController.text,
                  'images': [],
                },
                images: images,
              ),
            );
          },
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Save",
              style: AppStyles.medium(size: 18),
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.primaryColor,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Create a new note",
            style: AppStyles.medium(
              size: 20,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: BlocBuilder<FirestoreBlocBloc, FirestoreBlocState>(
              builder: (context, state) {
            return LoadingOverlayWidget(
              isLoading: state.saveNoteLoading,
              child: SingleChildScrollView(
                child: BackgroundApp(
                  opacity: 0.8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                            enabled: false,
                            controller: _nameController,
                            decoration:
                                InputDecoration(prefixIcon: Icon(Icons.face)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                            enabled: false,
                            controller: _dateController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.calendar_today)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                            enabled: false,
                            controller: _timeController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.schedule)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                            controller: _noteController,
                            minLines: 3,
                            maxLines: 10,
                            decoration:
                                InputDecoration(hintText: "How it's going"),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  var image = await ImagePicker()
                                      .getImage(source: ImageSource.gallery);
                                  if (image != null) {
                                    setState(() {
                                      images.add(File(image.path));
                                    });
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: AppColors.secondaryColor)),
                                  height: 90,
                                  width: 90,
                                  child: Icon(Icons.camera),
                                ),
                              )
                            ]..addAll(
                                images.map((e) {
                                  return Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.file(
                                            e,
                                            height: 90,
                                            width: 90,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 4,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              images.remove(e);
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryColor,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.clear,
                                              size: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                }).toList(),
                              ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
