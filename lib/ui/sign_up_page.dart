



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/cubit/auth/auth_cubit.dart';
import 'package:note_app/cubit/credential/credential_cubit.dart';
import 'package:note_app/models/user_model.dart';
import 'package:note_app/router/page_const.dart';
import 'package:note_app/ui/home_page.dart';
import 'package:note_app/ui/widgets/common/common.dart';
import 'package:note_app/ui/widgets/custom_button.dart';
import 'package:note_app/ui/widgets/custom_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {


  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CredentialCubit,CredentialState>(
        listener: (context,credentialState){

          if (credentialState is CredentialSuccess){
            context.read<AuthCubit>().loggedIn(credentialState.user.uid!);
          }

          if (credentialState is CredentialFailure){
            showSnackBarMessage(credentialState.errorMessage,context);
          }


        },
        builder: (context,credentialState){


          if (credentialState is CredentialLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (credentialState is CredentialSuccess){

            return BlocBuilder<AuthCubit,AuthState>(builder: (context,authState){


              if (authState is Authenticated){
                return HomePage(uid:authState.uid);
              }else{

                return _bodyWidget();
              }

            });

          }


          return _bodyWidget();
        },
      ),
    );
  }

  Widget _bodyWidget(){
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
            Center(child: Text("Note App",style: TextStyle(fontSize: 50),)),
            SizedBox(height: 50,),
            CustomTextField(
              hint: "Username",
              controller: _usernameController,
            ),
            SizedBox(height: 20,),
            CustomTextField(
              hint: "Email",
              controller: _emailController,
            ),
            SizedBox(height: 20,),
            CustomTextField(
              hint: "Password",
              controller: _passwordController,
              obscureText: true,
            ),
            SizedBox(height: 20,),
            CustomButton(title: "Sign Up",onTap: _submitSignUp,),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Already have an account"),
                InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context, PageConst.signInPage, (route) => false);
                  },
                  child: Text(
                    " Sign In",
                    style: TextStyle(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .inversePrimary),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _submitSignUp() {


    if (_usernameController.text.isEmpty){
      showSnackBarMessage("Enter Username", context);
      return;
    }

    if (_emailController.text.isEmpty){
      showSnackBarMessage("Enter Email", context);
      return;
    }

    if (_passwordController.text.isEmpty){
      showSnackBarMessage("Enter Password", context);
      return;
    }

    context.read<CredentialCubit>().signUp(UserModel(
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    ));
  }
}