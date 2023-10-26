import 'dart:convert';

import 'package:responsi/helpers/api.dart';
import 'package:responsi/helpers/api_url.dart';
import 'package:responsi/model/assignments.dart';

class AssignmentsBloc {
  static Future<List<Assignments>> getAssignments() async {
    String apiUrl = ApiUrl.listAssignments;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listAssignments = (jsonObj as Map<String, dynamic>)['result'];
    List<Assignments> assignments = [];
    for (int i = 0; i < listAssignments.length; i++) {
      assignments.add(Assignments.fromJson(listAssignments[i]));
    }
    return assignments;
  }

  static Future addAssignments({Assignments? assignments}) async {
    String apiUrl = ApiUrl.createAssignments;
    var body = {
      "title": assignments!.title,
      "description": assignments.description,
      "deadline": assignments.deadline
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<String> updateAssignments(
      {required Assignments assignments}) async {
    String apiUrl = ApiUrl.updateAssignments(assignments.id!);
    var body = {
      "title": assignments!.title,
      "description": assignments.description,
      "deadline": assignments.deadline
    };
    var response = await Api().put(apiUrl, body);
    var jsonObj = json.decode(response.body);
    print("JsonObj : ${jsonObj['result']}");
    return jsonObj['message'];
  }

  static Future<bool> deleteAssignments({int? id}) async {
    String apiUrl = ApiUrl.deleteAssignments(id!);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['result'];
  }
}
