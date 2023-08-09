import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/repository/network_repository.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final networkRepository = NetworkRepository();
  NoteCubit() : super(NoteInitial());



  Future<void> addNote(NoteModel note)async{

    try{

      await networkRepository.addNote(note);

    }catch(_){
      emit(NoteFailure());
    }

  }


  Future<void> updateNote(NoteModel note)async{

    try{

      await networkRepository.updateNote(note);

    }catch(_){
      emit(NoteFailure());
    }

  }

  Future<void> deleteNote(NoteModel note)async{

    try{

      await networkRepository.deleteNote(note);

    }catch(_){
      emit(NoteFailure());
    }

  }

  Future<void> getMyNotes(NoteModel note)async{
    emit(NoteLoading());
    try{

    final noteData =  await networkRepository.getMyNotes(note);

    emit(NoteLoaded(noteData));

    }catch(_){
      emit(NoteFailure());
    }

  }
}
