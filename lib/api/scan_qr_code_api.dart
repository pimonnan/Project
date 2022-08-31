import 'package:flutter/material.dart';

class ScanQR {
  Future<String> scanQRS(String s_id, String a_id) async {
    Map data = {
      's_id': s_id,
      'a_id': a_id,
    };

    // final response =
    // await http.post(apiurl + "/updatepassword.php", body: data);
    //   final response =
    //       await http.post(apiurl + "/Warehouse/updatepassword.php", body: data);
    //   if (response.statusCode == 200) {
    //     // print("Update Response: " + response.body);
    //     return response.body;
    //   } else if (response.statusCode == 404) {
    //     return "Error";
    //   }
    // }
  }
}
