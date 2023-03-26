import 'package:http/http.dart' as http;
import 'package:projectnan/untils/constants.dart';

class UpdateActivity {
  Future<String> updateActivity(String a_id, int a_status) async {
    Map data = {
      'a_id': a_id,
      'a_status': a_status.toString(),
    };

    final response =
        await http.post(apiurl + "/Warehouse/update_activity.php", body: data);
    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 404) {
      return "Error";
    }
  }
}
