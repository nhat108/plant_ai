part of 'firestore_bloc_bloc.dart';

abstract class FirestoreBlocEvent {}

class SavePlant extends FirestoreBlocEvent {
  final String id;
  final Map<String, dynamic> body;

  SavePlant({@required this.id, @required this.body});
}

class SaveToRecentSnap extends FirestoreBlocEvent {
  final String id;
  final Map<String, dynamic> body;

  SaveToRecentSnap({@required this.id, @required this.body});
}

class GetListMyPlant extends FirestoreBlocEvent {}

class DeletePlant extends FirestoreBlocEvent {
  final String plantId;

  DeletePlant({@required this.plantId});
}

class SaveNote extends FirestoreBlocEvent {
  final String plantId;
  final Map<String, dynamic> body;
  final List<File> images;
  SaveNote(
      {@required this.plantId, @required this.body, @required this.images});
}

class UpdateNote extends FirestoreBlocEvent {
  final String plantId;
  final Map<String, dynamic> body;
  final List<File> images;
  final String noteId;
  final List<String> imagesUploaded;

  UpdateNote({
    @required this.plantId,
    @required this.body,
    @required this.images,
    @required this.noteId,
    @required this.imagesUploaded,
  });
}

class DeleteNote extends FirestoreBlocEvent {
  final String plantId;
  final String noteId;

  DeleteNote({@required this.plantId, @required this.noteId});
}

class SaveReminder extends FirestoreBlocEvent {
  final String plantId;
  final Map<String, dynamic> body;

  SaveReminder({@required this.plantId, @required this.body});
}

class ChangeFavourite extends FirestoreBlocEvent {
  final String plantId;
  final Map<String, dynamic> body;

  ChangeFavourite({@required this.plantId, @required this.body});
}

///RECENT SNAP
class AddToRecentSnap extends FirestoreBlocEvent {
  final Map<String, dynamic> body;
  final String plantId;
  AddToRecentSnap({@required this.body, @required this.plantId});
}

class MoveRecentSnapToMyPlant extends FirestoreBlocEvent {
  final String plantId;
  final Map<String, dynamic> body;

  MoveRecentSnapToMyPlant({@required this.plantId, @required this.body});
}

///List Reminders
class GetListReminders extends FirestoreBlocEvent {}
