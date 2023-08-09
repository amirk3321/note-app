




import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/cubit/note/note_cubit.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/ui/widgets/common/common.dart';
import 'package:note_app/ui/widgets/custom_button.dart';
import 'package:note_app/ui/widgets/custom_text_field.dart';

class UpdateNotePage extends StatefulWidget {
  final NoteModel note;
  const UpdateNotePage({super.key,required this.note});

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {


  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _titleController.value = TextEditingValue(text: widget.note.title!);
    _descriptionController.value = TextEditingValue(text: widget.note.description!);
    super.initState();
  }




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
        title: Text("Update Note"),
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
            CustomButton(title: "Update Note",onTap: _updateNote,)
          ],
        ),
      ),
    );
  }

  void _updateNote() {

    if (_titleController.text.isEmpty){
      showSnackBarMessage("Enter Note Name", context);
      return;
    }

    if (_descriptionController.text.isEmpty){
      showSnackBarMessage("Enter Description", context);
      return;
    }

    context.read<NoteCubit>().updateNote(NoteModel(
      title: _titleController.text,
      description: _descriptionController.text,
      noteId: widget.note.noteId,
      createAt: DateTime.now().millisecondsSinceEpoch
    ));


    showSnackBarMessage("Note Updated Successfully", context);
  }
}
