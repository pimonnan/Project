import 'package:flutter/material.dart';
import 'package:projectnan/model/activity.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateQR extends StatefulWidget {
  Activity activity;
  CreateQR(this.activity);

  @override
  State<CreateQR> createState() => _CreateQRState(activity);
}

class _CreateQRState extends State<CreateQR> {
  String qrData = "https://github.com/neon97";
  Activity activity;
  _CreateQRState(this.activity);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    qrData =
        activity.a_id; //ดึงข้อความในฐานข้อมูลมาโดยเราดึงรหัสของกิจกรรมออกมา
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR CODE"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                QrImage(data: qrData),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final qrText = TextEditingController();
}
