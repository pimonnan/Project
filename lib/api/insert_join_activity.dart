import 'package:http/http.dart' as http;
import 'package:projectnan/untils/constants.dart';

class InsertJoinActivity {
  // ignore: missing_return
  Future<String> insertJoinActivity(String aId, String sId) async {
    Map data = {
      'a_id': aId,
      's_id': sId,
    };
    final response = await http
        .post(apiurl + "/Warehouse/add_join_activity.php", body: data);
    if (response.statusCode == 200) {
      print("Update Response: " + response.body);
      return response.body;
    } else if (response.statusCode == 404) {
      return "Error";
    }
  }
}
