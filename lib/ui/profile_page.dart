import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/cubit/user/user_cubit.dart';
import 'package:note_app/models/user_model.dart';
import 'package:note_app/ui/widgets/common/common.dart';
import 'package:note_app/ui/widgets/custom_button.dart';
import 'package:note_app/ui/widgets/custom_text_field.dart';

class ProfilePage extends StatefulWidget {
  final String uid;

  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();


  @override
  void initState() {
    context.read<UserCubit>().myProfile(UserModel(uid: widget.uid));
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text("Update Profile"),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {

          if (userState is UserLoaded){

            _updateDetails(userState.user);

            return Container(
              margin: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("username"),
                  SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                      hint: "username", controller: _usernameController),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Email"),
                  SizedBox(
                    height: 5,
                  ),
                  AbsorbPointer(
                      child: CustomTextField(
                        hint: "Email",
                        controller: _emailController,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    title: "Update Profile",
                    onTap: _updateProfile,
                  ),

                ],
              ),
            );
          }

         return Center(
           child: CircularProgressIndicator(),
         );
        },
      ),
    );
  }

  void _updateProfile() {

    if (_usernameController.text.isEmpty){
      showSnackBarMessage("Enter Username", context);
      return;
    }

    context.read<UserCubit>().updateProfile(UserModel(
      uid: widget.uid,
      username: _usernameController.text
    )).then((value) {
      showSnackBarMessage("Profile Updated Successfully", context);
    });


  }

  void _updateDetails(UserModel user) {
    _emailController.value = TextEditingValue(text: user.email!);
    _usernameController.value = TextEditingValue(text: user.username!);
  }
}
