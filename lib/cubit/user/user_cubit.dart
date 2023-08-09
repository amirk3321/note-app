import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app/models/user_model.dart';
import 'package:note_app/repository/network_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final networkRepository = NetworkRepository();
  UserCubit() : super(UserInitial());



  Future<void> myProfile(UserModel user) async{
    try{

    final userData = await  networkRepository.myProfile(user);

    emit(UserLoaded(userData));

    }catch(_){
      emit(UserFailure());
    }
  }

  Future<void> updateProfile(UserModel user) async{
    try{

    await  networkRepository.updateProfile(user);

    }catch(_){
      emit(UserFailure());
    }
  }

}

