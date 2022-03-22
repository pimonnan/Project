import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projectnan/model/activity.dart';
import 'package:projectnan/untils/constants.dart';

class Activityapi {
  static Future<List<Activity>> getsearchactivity(String query) async {
    final url = Uri.parse(apiurl + '/Warehouse/getactivity.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List activitys = json.decode(response.body);

      return activitys.map((json) => Activity.fromJson(json)).where((activity) {
        final titleLower = activity.a_name.toLowerCase();
        // final desLower = activity.a_decription.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower);
        // || desLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
