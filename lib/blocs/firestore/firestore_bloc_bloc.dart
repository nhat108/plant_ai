import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flower/configs/app_config.dart';
import 'package:flower/models/note.dart';
import 'package:flower/models/plant.dart';
import 'package:flower/models/reminder.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
part 'firestore_bloc_event.dart';
part 'firestore_bloc_state.dart';

class FirestoreBlocBloc extends Bloc<FirestoreBlocEvent, FirestoreBlocState> {
  FirestoreBlocBloc() : super(FirestoreBlocState.empty());
  FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Stream<FirestoreBlocState> mapEventToState(
    FirestoreBlocEvent event,
  ) async* {
    if (event is SavePlant) {
      try {
        await _db
            .collection('users')
            .doc(AppConfig().deviceId)
            .collection('plant_saved')
            .doc(event.id)
            .set(event.body);
      } catch (e) {
        print(e);
      }
    }
    if (event is DeletePlant) {
      try {
        yield state.copyWith(
          deletePlantLoading: true,
        );
        await _db
            .collection('users')
            .doc(AppConfig().deviceId)
            .collection('plant_saved')
            .doc(event.plantId)
            .delete();
        yield state.copyWith(
          deletePlantSuccess: true,
        );
      } catch (e) {
        print(e);
      }
      yield state.copyWith(
        deletePlantSuccess: false,
        deletePlantLoading: false,
      );
    }

    if (event is RemoveFavourite) {
      try {
        yield state.copyWith(removeFavouriteLoading: true);
        await _db
            .collection('users')
            .doc(AppConfig().deviceId)
            .collection('plant_saved')
            .doc(event.plantId)
            .delete();
        yield state.copyWith(
          removeFavouriteLoading: false,
        );
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
        yield state.copyWith(
          removeFavouriteError: e.toString(),
          removeFavouriteLoading: false,
        );
      }
      yield state.copyWith(
        removeFavouriteError: '',
        removeFavouriteLoading: false,
      );
    }
    if (event is SaveToRecentSnap) {
      try {
        await _db
            .collection('users')
            .doc(AppConfig().deviceId)
            .collection('recent_snaps')
            .doc(event.id)
            .set(event.body);
      } catch (e) {
        print(e);
      }
    }
    if (event is SaveNote) {
      try {
        yield state.copyWith(
          saveNoteLoading: true,
        );
        await _db
            .collection('users')
            .doc(AppConfig().deviceId)
            .collection('plant_saved')
            .doc(event.plantId)
            .collection('notes')
            .add(event.body);
        yield state.copyWith(
          saveNoteLoading: false,
          saveNoteSuccess: true,
        );
      } catch (e) {
        yield state.copyWith(
            saveNoteError: e.toString(), saveNoteLoading: false);
      }
      yield state.copyWith(
        saveNoteError: '',
        saveNoteLoading: false,
        saveNoteSuccess: false,
      );
    }
    if (event is UpdateNote) {
      try {
        yield state.copyWith(
          saveNoteLoading: true,
        );
        await _db
            .collection('users')
            .doc(AppConfig().deviceId)
            .collection('plant_saved')
            .doc(event.plantId)
            .collection('notes')
            .doc(event.noteId)
            .set(event.body);
        yield state.copyWith(
          saveNoteLoading: false,
          saveNoteSuccess: true,
        );
      } catch (e) {
        yield state.copyWith(
            saveNoteError: e.toString(), saveNoteLoading: false);
      }
      yield state.copyWith(
        saveNoteError: '',
        saveNoteLoading: false,
        saveNoteSuccess: false,
      );
    }
    if (event is DeleteNote) {
      try {
        yield state.copyWith(
          saveNoteLoading: true,
        );
        await _db
            .collection('users')
            .doc(AppConfig().deviceId)
            .collection('plant_saved')
            .doc(event.plantId)
            .collection('notes')
            .doc(event.noteId)
            .delete();
        yield state.copyWith(
          saveNoteLoading: false,
          deleteNoteSuccess: true,
        );
      } catch (e) {
        yield state.copyWith(
            saveNoteError: e.toString(), saveNoteLoading: false);
      }
      yield state.copyWith(
        saveNoteError: '',
        saveNoteLoading: false,
        deleteNoteSuccess: false,
      );
    }

    if (event is SaveReminder) {
      try {
        yield state.copyWith(
          saveReminderLoading: true,
        );
        await _db
            .collection('users')
            .doc(AppConfig().deviceId)
            .collection('plant_saved')
            .doc(event.plantId)
            .collection('reminders')
            .doc(event.body['type'].toString())
            .set(event.body);
        yield state.copyWith(
          saveReminderLoading: false,
          saveReminderSuccess: true,
        );
      } catch (e) {
        yield state.copyWith(
            saveReminderError: e.toString(), saveReminderLoading: false);
      }
      yield state.copyWith(
        saveReminderLoading: false,
        saveReminderError: '',
        saveReminderSuccess: false,
      );
    }

    ///RECENT SNAP
    if (event is AddToRecentSnap) {
      try {
        await _db
            .collection('users')
            .doc(AppConfig().deviceId)
            .collection('recent_snaps')
            .doc(event.plantId)
            .set(event.body);
      } catch (e) {
        print(e);
      }
    }
    if (event is MoveRecentSnapToMyPlant) {
      try {
        await _db
            .collection('users')
            .doc(AppConfig().deviceId)
            .collection('recent_snaps')
            .doc(event.plantId)
            .delete();
        add(SavePlant(id: event.plantId, body: event.body));
      } catch (e) {
        Fluttertoast.showToast(msg: e);
      }
    }
  }

  Stream<List<Plant>> getListMyPlantStream() {
    return _db
        .collection('users')
        .doc(AppConfig().deviceId)
        .collection('plant_saved')
        .snapshots()
        .asyncMap((event) {
      return event.docs.map((e) {
        return Plant.fromJson(e.data());
      }).toList();
    });
  }

  Stream<List<Note>> getListNotes(String plantId) {
    return _db
        .collection('users')
        .doc(AppConfig().deviceId)
        .collection('plant_saved')
        .doc(plantId)
        .collection('notes')
        .orderBy('date', descending: true)
        .snapshots()
        .asyncMap((event) => event.docs
            .map((e) => Note.fromJson(e.data()..addAll({'id': e.id})))
            .toList());
  }

  Stream<List<Reminder>> getListReminders(String plantId) {
    return _db
        .collection('users')
        .doc(AppConfig().deviceId)
        .collection('plant_saved')
        .doc(plantId)
        .collection('reminders')
        .orderBy('type', descending: true)
        .snapshots()
        .asyncMap((event) =>
            event.docs.map((e) => Reminder.fromJson(e.data())).toList());
  }

  Stream<bool> isFavourite(String plantId) {
    return _db
        .collection('users')
        .doc(AppConfig().deviceId)
        .collection('plant_saved')
        .doc(plantId)
        .snapshots()
        .asyncMap((event) {
      return event.exists;
    });
  }

  Stream<List<Plant>> getListRecentSnap() {
    return _db
        .collection('users')
        .doc(AppConfig().deviceId)
        .collection('recent_snaps')
        .snapshots()
        .asyncMap((event) {
      return event.docs.map((e) {
        return Plant.fromJson(e.data());
      }).toList();
    });
  }
}
