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
  }

  Stream<List<Plant>> getListMyPlantStream() {
    print(AppConfig().deviceId);
    return _db
        .collection('users')
        .doc(AppConfig().deviceId)
        .collection('plant_saved')
        .snapshots()
        .asyncMap((event) =>
            event.docs.map((e) => Plant.fromJson(e.data())).toList());
  }

  Stream<List<Note>> getListNotes(String plantId) {
    print(AppConfig().deviceId);
    return _db
        .collection('users')
        .doc(AppConfig().deviceId)
        .collection('plant_saved')
        .doc(plantId)
        .collection('notes')
        .orderBy('date', descending: true)
        .snapshots()
        .asyncMap(
            (event) => event.docs.map((e) => Note.fromJson(e.data())).toList());
  }

  Stream<List<Reminder>> getListReminders(String plantId) {
    print(AppConfig().deviceId);
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
}
