


import 'package:shared_preferences/shared_preferences.dart';


const _currentUserId = "currentUserId";

class SharedPref{



  void setUid(String uid)async{
    final pref =await SharedPreferences.getInstance();

    pref.setString(_currentUserId, uid);
  }

  Future<String?> getUid() async{
    final pref =await SharedPreferences.getInstance();

    return pref.getString(_currentUserId);
  }
}