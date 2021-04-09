part of 'firestore_bloc_bloc.dart';

class FirestoreBlocState extends Equatable {
  final bool savePlantLoading;
  final String savePlantError;
  final bool savePlantSuccess;
  final bool saveNoteLoading;
  final String saveNoteError;
  final bool saveNoteSuccess;
  final bool saveReminderLoading;
  final String saveReminderError;
  final bool saveReminderSuccess;

  FirestoreBlocState({
    this.savePlantError,
    this.saveNoteLoading,
    this.saveNoteError,
    this.savePlantLoading,
    this.saveNoteSuccess,
    this.savePlantSuccess,
    this.saveReminderError,
    this.saveReminderLoading,
    this.saveReminderSuccess,
  });

  @override
  List<Object> get props => [
        this.savePlantError,
        this.saveNoteLoading,
        this.saveNoteError,
        this.savePlantLoading,
        this.saveNoteSuccess,
        this.savePlantSuccess,
        this.saveReminderError,
        this.saveReminderLoading,
        this.saveReminderSuccess,
      ];
  factory FirestoreBlocState.empty() {
    return FirestoreBlocState(
        savePlantLoading: false,
        saveNoteError: '',
        saveNoteLoading: false,
        savePlantError: '',
        saveNoteSuccess: false,
        savePlantSuccess: false,
        saveReminderError: '',
        saveReminderLoading: false,
        saveReminderSuccess: false);
  }

  FirestoreBlocState copyWith({
    final bool savePlantLoading,
    final String savePlantError,
    final bool saveNoteLoading,
    final String saveNoteError,
    final bool saveNoteSuccess,
    final bool savePlantSuccess,
    final bool saveReminderLoading,
    final String saveReminderError,
    final bool saveReminderSuccess,
  }) {
    return FirestoreBlocState(
      saveReminderError: saveReminderError ?? this.saveReminderError,
      saveReminderLoading: saveReminderLoading ?? this.saveReminderLoading,
      saveReminderSuccess: saveReminderSuccess ?? this.saveReminderSuccess,
      saveNoteSuccess: saveNoteSuccess ?? this.saveNoteSuccess,
      savePlantSuccess: savePlantSuccess ?? this.savePlantSuccess,
      saveNoteError: saveNoteError ?? this.saveNoteError,
      saveNoteLoading: saveNoteLoading ?? this.saveNoteLoading,
      savePlantError: savePlantError ?? this.savePlantError,
      savePlantLoading: savePlantLoading ?? this.savePlantLoading,
    );
  }
}
