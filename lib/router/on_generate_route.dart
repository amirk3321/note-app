


import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/router/page_const.dart';
import 'package:note_app/ui/add_note_page.dart';
import 'package:note_app/ui/profile_page.dart';
import 'package:note_app/ui/sign_in_page.dart';
import 'package:note_app/ui/sign_up_page.dart';
import 'package:note_app/ui/update_note_page.dart';

class OnGenerateRoute{


  static Route<dynamic> route(RouteSettings settings){


    final args = settings.arguments;


    switch(settings.name){

      case PageConst.signUpPage : {
        return materialPageBuilder(widget: SignUpPage());
      }
      case PageConst.signInPage : {
        return materialPageBuilder(widget: SignInPage());
      }

      case PageConst.profilePage : {

        if (args is String){
          return materialPageBuilder(widget: ProfilePage(uid: args,));
        }else{
          return materialPageBuilder(widget: ErrorPage());
        }


      }
    case PageConst.addNotePage : {

      if (args is String){
        return materialPageBuilder(widget: AddNotePage(uid: args,));
      }else{
        return materialPageBuilder(widget: ErrorPage());
      }

      }
      case PageConst.updateNotePage : {
        if (args is NoteModel){
          return materialPageBuilder(widget: UpdateNotePage(note: args,));
        }else{
          return materialPageBuilder(widget: ErrorPage());
        }


      }

      default:
        return materialPageBuilder(widget: ErrorPage());


    }


  }

}


class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("error"),
      ),
      body: Center(
        child: Text("error"),
      ),
    );
  }
}



MaterialPageRoute materialPageBuilder({required Widget widget}){
  return MaterialPageRoute(builder: (_) =>widget);
}

