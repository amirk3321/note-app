



import 'package:equatable/equatable.dart';

class NoteModel extends Equatable{

  final String? noteId;
  final String? title;
  final String? description;
  final num? createAt;
  final String? creatorId;

  NoteModel(
      {this.noteId,
      this.title,
      this.description,
      this.createAt,
      this.creatorId});


  factory NoteModel.fromJson(Map<String,dynamic> json){
    return NoteModel(
      noteId: json['_id'],
      title: json['title'],
      description: json['description'],
      createAt: json['createAt'],
      creatorId: json['creatorId'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "noteId": noteId,
      "title": title,
      "description": description,
      "createAt": createAt,
      "creatorId": creatorId,
    };
  }



  @override
  // TODO: implement props
  List<Object?> get props => [noteId,title,description,createAt,creatorId];
}