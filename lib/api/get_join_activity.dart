import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projectnan/model/join_activity.dart';
import 'package:projectnan/untils/constants.dart';

class GetJoinActivityapi {
  static Future<List<JoinActivity>> getJoinActivity(String a_id) async {
    Map data = {
      'a_id': a_id,
    };
    final url = Uri.parse(apiurl + '/Warehouse/get_join_activity.php');
    // final url = Uri.parse(apiurl + '/getactivity.php');
    final response = await http.post(url, body: data);

    if (response.statusCode == 200) {
      final List joinactivity = json.decode(response.body);
      return joinactivity.map((json) => JoinActivity.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }
}
