import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projectnan/model/personnel.dart';
import 'package:projectnan/untils/constants.dart';

class Personnelapi {
  List<Personnel> personnelFromJSON(String jsonString) {
    final data = json.decode(jsonString);
    return List<Personnel>.from(data.map((item) => Personnel.fromMap(item)));
  }

  Future<List<Personnel>> getpersonnel(String p_id) async {
    Map data = {'p_id': p_id};
    // final url = Uri.parse(apiurl + '/getstudent.php');
    final url = Uri.parse(apiurl + '/Warehouse/getpersonnel.php');
    final response = await http.post(url, body: data);
    var jsonData = null;
    if (response.statusCode == 200) {
      List<Personnel> personnelList = personnelFromJSON(response.body);
      return personnelList;
    } else {
      throw Exception();
    }
  }
}
