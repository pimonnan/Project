import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projectnan/model/student.dart';
import 'package:projectnan/untils/constants.dart';

class Studentapi {
  List<Students> studentsFromJSON(String jsonString) {
    final data = json.decode(jsonString);
    return List<Students>.from(data.map((item) => Students.fromMap(item)));
  }

  Future<List<Students>> getstudent(String s_id) async {
    Map data = {'s_id': s_id};
    // final url = Uri.parse(apiurl + '/getstudent.php');
    final url = Uri.parse(apiurl + '/Warehouse/getstudent.php');
    final response = await http.post(url, body: data);
    var jsonData = null;
    if (response.statusCode == 200) {
      List<Students> studentsList = studentsFromJSON(response.body);
      return studentsList;
    } else {
      throw Exception();
    }
  }
}
