import 'package:http/http.dart' as http;
import 'package:projectnan/untils/constants.dart';

class ScanQR {
  // ignore: missing_return
  Future<String> scanqrRequest(String sId, String aId) async {
    Map data = {
      's_id': sId,
      'a_id': aId,
    };

    final response = await http
        .post(apiurl + "/Warehouse/update_join_activity.php", body: data);
    if (response.statusCode == 200) {
      // print("Update Response: " + response.body);
      return response.body;
    } else if (response.statusCode == 404) {
      return "Error";
    }
  }
}
