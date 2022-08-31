import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projectnan/model/student.dart';
import 'package:projectnan/untils/constants.dart';
import 'package:toast/toast.dart';

class UpdatePassword {
  Future<String> updatePasswordS(
      String s_id, String s_password, String b_password) async {
    Map data = {
      's_id': s_id,
      's_password': s_password,
      'b_password': b_password
    };
    // final response =
    // await http.post(apiurl + "/updatepassword.php", body: data);
    final response =
        await http.post(apiurl + "/Warehouse/updatepassword.php", body: data);
    if (response.statusCode == 200) {
      // print("Update Response: " + response.body);
      return response.body;
    } else if (response.statusCode == 404) {
      return "Error";
    }
  }
}
