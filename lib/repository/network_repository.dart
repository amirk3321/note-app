import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:note_app/models/note_model.dart';
import 'package:note_app/models/user_model.dart';

class ServerException implements Exception {
  final String errorMessage;

  ServerException(this.errorMessage);
}

class NetworkRepository {
  final http.Client httpClient = http.Client();

  String _endPoint(String endPoint) {
    return "http://localhost:5001/v1/$endPoint";
  }

  Map<String, String> _header = {
    "Content-Type": "application/json; charset=utf-8"
  };

  Future<UserModel> signUp(UserModel user) async {
    final encodedParams = json.encode(user.toJson());

    final response = await httpClient.post(Uri.parse(_endPoint("user/signUp")),
        body: encodedParams, headers: _header);

    if (response.statusCode == 200) {
      final userModel =
          UserModel.fromJson(json.decode(response.body)['response']);

      return userModel;
    } else {
      throw ServerException(json.decode(response.body)['response']);
    }
  }

  Future<UserModel> signIn(UserModel user) async {
    final encodedParams = json.encode(user.toJson());

    final response = await httpClient.post(Uri.parse(_endPoint("user/signIn")),
        body: encodedParams, headers: _header);

    if (response.statusCode == 200) {
      final userModel =
          UserModel.fromJson(json.decode(response.body)['response']);

      return userModel;
    } else {
      throw ServerException(json.decode(response.body)['response']);
    }
  }

  Future<UserModel> myProfile(UserModel user) async {
    final response = await httpClient.get(
        Uri.parse(_endPoint("user/myProfile?uid=${user.uid}")),
        headers: _header);

    if (response.statusCode == 200) {
      final userModel =
          UserModel.fromJson(json.decode(response.body)['response']);

      return userModel;
    } else {
      throw ServerException(json.decode(response.body)['response']);
    }
  }

  Future<UserModel> updateProfile(UserModel user) async {
    final encodedParams = json.encode(user.toJson());

    final response = await httpClient.put(
        Uri.parse(_endPoint("user/updateProfile")),
        body: encodedParams,
        headers: _header);

    if (response.statusCode == 200) {
      final userModel =
          UserModel.fromJson(json.decode(response.body)['response']);

      return userModel;
    } else {
      throw ServerException(json.decode(response.body)['response']);
    }
  }

  Future<List<NoteModel>> getMyNotes(NoteModel note) async {
    final response = await httpClient.get(
        Uri.parse(_endPoint("note/getMyNotes?uid=${note.creatorId}")),
        headers: _header);

    if (response.statusCode == 200) {
      List<dynamic> notes = json.decode(response.body)['response'];

      final notesData = notes.map((item) => NoteModel.fromJson(item)).toList();

      return notesData;
    } else {
      throw ServerException(json.decode(response.body)['response']);
    }
  }

  Future<void> addNote(NoteModel note) async {
    final encodedParams = json.encode(note.toJson());

    final response = await httpClient.post(Uri.parse(_endPoint("note/addNote")),
        body: encodedParams, headers: _header);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw ServerException(json.decode(response.body)['response']);
    }
  }

  Future<void> updateNote(NoteModel note) async {
    final encodedParams = json.encode(note.toJson());

    final response = await httpClient.put(Uri.parse(_endPoint("note/updateNote")),
        body: encodedParams, headers: _header);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw ServerException(json.decode(response.body)['response']);
    }
  }

  Future<void> deleteNote(NoteModel note) async {
    final encodedParams = json.encode(note.toJson());

    final response = await httpClient.delete(Uri.parse(_endPoint("note/deleteNote")),
        body: encodedParams, headers: _header);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw ServerException(json.decode(response.body)['response']);
    }
  }
}
