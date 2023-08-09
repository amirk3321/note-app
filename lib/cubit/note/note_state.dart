part of 'note_cubit.dart';

abstract class NoteState extends Equatable {
  const NoteState();
}

class NoteInitial extends NoteState {
  @override
  List<Object> get props => [];
}

class NoteLoading extends NoteState {
  @override
  List<Object> get props => [];
}

class NoteLoaded extends NoteState {
  final List<NoteModel> notes;

  NoteLoaded(this.notes);
  @override
  List<Object> get props => [notes];
}

class NoteFailure extends NoteState {
  @override
  List<Object> get props => [];
}