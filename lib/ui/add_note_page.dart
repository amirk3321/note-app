


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/cubit/note/note_cubit.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/ui/widgets/common/common.dart';
import 'package:note_app/ui/widgets/custom_button.dart';
import 'package:note_app/ui/widgets/custom_text_field.dart';

class AddNotePage extends StatefulWidget {
  final String uid;
  const AddNotePage({super.key,required this.uid});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {


  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();


  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Add New Note"),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
            CustomTextField(hint: "title",controller: _titleController),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.1),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextField(
                maxLines: 10,
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: "Description",
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20,),
            CustomButton(title: "Add Note",onTap: _addNewNote,)
          ],
        ),
      ),
    );
  }

  void _addNewNote() {

    if (_titleController.text.isEmpty){
      showSnackBarMessage("Enter Note Name", context);
      return;
    }

    if (_descriptionController.text.isEmpty){
      showSnackBarMessage("Enter Description", context);
      return;
    }

    context.read<NoteCubit>().addNote(NoteModel(
      title: _titleController.text,
      description: _descriptionController.text,
      creatorId: widget.uid,
    )).then((value) {
      _clear();
    });


  }

  void _clear(){
    _titleController.clear();
    _descriptionController.clear();
    showSnackBarMessage("New Note added successfully", context);
    setState(() {

    });
  }
}
