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

class SaveNote extends FirestoreBlocEvent {
  final String plantId;
  final Map<String, dynamic> body;
  final List<File> images;
  SaveNote(
      {@required this.plantId, @required this.body, @required this.images});
}

class SaveReminder extends FirestoreBlocEvent {
  final String plantId;
  final Map<String, dynamic> body;

  SaveReminder({@required this.plantId, @required this.body});
}
