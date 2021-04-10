import 'package:flower/blocs/firestore/firestore_bloc_bloc.dart';
import 'package:flower/configs/app_colors.dart';
import 'package:flower/configs/app_styles.dart';
import 'package:flower/models/note.dart';
import 'package:flower/models/plant.dart';
import 'package:flower/utils/custom_dialog.dart';
import 'package:flower/widgets/background_app.dart';
import 'package:flower/widgets/loading_overlay_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UpdateNotePage extends StatefulWidget {
  final Plant plant;
  final Note note;

  const UpdateNotePage({Key key, @required this.note, @required this.plant})
      : super(key: key);
  @override
  _UpdateNotePageState createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  var now = DateTime.now();
  @override
  void initState() {
    _nameController.text = widget.plant.commonName;

    _dateController.text =
        DateFormat.yMMMMd('en_US').format(DateTime.parse(widget.note.date));
    _timeController.text =
        DateFormat.jm().format(DateTime.parse(widget.note.date));
    _noteController.text = widget.note.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return BlocListener<FirestoreBlocBloc, FirestoreBlocState>(
      listener: (_, state) {
        if (state.deleteNoteSuccess) {
          Navigator.pop(context);
        }
        if (state.saveNoteSuccess) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: showFab
            ? FloatingActionButton.extended(
                onPressed: () {
                  BlocProvider.of<FirestoreBlocBloc>(context).add(
                    UpdateNote(
                      plantId: widget.plant.id.toString(),
                      body: {
                        'name': widget.plant.commonName,
                        'date': now.toIso8601String(),
                        'note': _noteController.text,
                        'images': [],
                      },
                      noteId: widget.note.id,
                      images: [],
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
              )
            : Container(),
        appBar: AppBar(
          elevation: 0,
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
            "Update note",
            style: AppStyles.medium(
              size: 20,
              color: AppColors.primaryColor,
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: AppColors.primaryColor,
                ),
                onPressed: () {
                  BlocProvider.of<FirestoreBlocBloc>(context).add(DeleteNote(
                      plantId: widget.plant.id.toString(),
                      noteId: widget.note.id));
                })
          ],
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
                    margin: EdgeInsets.only(bottom: 50),
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
                                prefixIcon:
                                    Icon(Icons.calendar_today_outlined)),
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
                        const SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: AppColors.secondaryColor)),
                                height: 90,
                                width: 90,
                                child: Icon(Icons.camera_alt),
                              )
                            ],
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
