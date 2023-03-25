import 'package:barcode_scan/barcode_scan.dart';
import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectnan/api/insert_join_activity.dart';
import 'package:projectnan/api/scan_qr_code_api.dart';
import 'package:projectnan/model/activity.dart';
import 'package:projectnan/screens/create_qr_code.dart';
import 'package:projectnan/untils/dialog_widget.dart';
import 'package:projectnan/untils/space_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class DetailsActivity extends StatefulWidget {
  Activity activity;
  DetailsActivity(this.activity);

  @override
  State<DetailsActivity> createState() => _DetailsActivityState(activity);
}

class _DetailsActivityState extends State<DetailsActivity> {
  TextEditingController controller = new TextEditingController();
  Activity activity;
  _DetailsActivityState(this.activity);
  var formatting = DateFormat('d MMM yyyy', 'th'); //วันที่ไทย
  bool _loading = true;
  String p_Id;
  String s_Id;
  SharedPreferences sharedPreferences;
  String qrResult = '';

  @override
  void initState() {
    super.initState();
    _loading = false;
    _getLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดกิจกรรม'),
        centerTitle: true,
      ),
      body: (_loading
          ? Center(child: CircularProgressIndicator())
          : ListView(children: [_detailsactivity(context)])),
    );
  }

  Widget _detailsactivity(context) => Column(
        children: [
          // Padding(
          //   padding: EdgeInsets.all(10),
          //   child: Center(
          //     child: Image.network(
          //       'https://scontent.fbkk8-4.fna.fbcdn.net/v/t1.18169-9/268947_216414225067313_2210587_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=cdbe9c&_nc_eui2=AeHROxc_gKaeoCTLjio33ZFdJ6acQfibxfonppxB-JvF-lcWIK-UnjVZzQOlpesl4yBJBSwK-a3wsMOEhJR6KEet&_nc_ohc=LjLbCnseIiAAX8CCCtn&_nc_ht=scontent.fbkk8-4.fna&oh=00_AT_fqSkbKPBMVlcaw5EGzXc3uF4c4fjsQKsIVFXY1fMBrg&oe=62DC6C52',
          //       // width: 350,
          //     ),
          //   ),
          // ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Text(
                      'ชื่อกิจกรรม : ' + activity.a_name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'จำนวนที่เข้าร่วม : ' + activity.a_qty,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  textStatus(),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'รายละเอียด : ' + activity.a_decription,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'ผู้รับผิดชอบกิจกรรม : ' + activity.p_name,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Text(
                        'วันที่ : ' +
                            formatting
                                .formatInBuddhistCalendarThai(
                                    activity.a_datestart)
                                .toString() +
                            '\t\t',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        'ถึง : ' +
                            formatting
                                .formatInBuddhistCalendarThai(
                                    activity.a_dateend)
                                .toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Text(
                        'เวลา : ' +
                            DateFormat.jm().format(DateFormat("hh:mm")
                                .parse(activity.a_timestart)) +
                            ' \t\t',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        'ถึง : ' +
                            DateFormat.jm().format(
                                DateFormat("hh:mm").parse(activity.a_timeend)),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  verticalSpaceM,
                  qrButton(activity.a_id, s_Id),
                  verticalSpaceM,
                  // Text(qrResult),
                  // Text(activity.a_id),
                ],
              ),
            ),
          ),
        ],
      );

  textStatus() {
    if (activity.a_status == '0') {
      return Text(
        'สถานะ : กิจกรรมใหม่',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
      );
    } else if (activity.a_status == '1') {
      return Text(
        'สถานะ : กิจกรรมดำเนินการอยู่',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
      );
    } else if (activity.a_status == '2') {
      return Text(
        'สถานะ : เสร็จสิ้นกิจกรรม',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
      );
    } else {
      return Text('');
    }
  }

  _getLogin() async {
    //ดึงจากล็อกอิน id ของเจ้าหน้าที่
    sharedPreferences = await SharedPreferences.getInstance();
    final String pId = sharedPreferences.getString("p_id");
    final String sId = sharedPreferences.getString("s_id");

    setState(() {
      p_Id = pId;
      s_Id = sId;
    });
  }

  Widget qrButton(String aId, String sId) {
    // print(_p_id);
    if (p_Id != null) {
      //ของเจ้าหน้าที่
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateQR(activity)),
              );
            },
            child: const Text('สร้าง OR Code'),
          ),
          ElevatedButton(
            onPressed: () {
              addIdDialog();
            },
            child: const Text('เพิ่มรหัสนักศึกษา'),
          ),
        ],
      );
    } else {
      //ของนักศึกษา
      return Center(
        child: ElevatedButton(
          onPressed: () async {
            String scaning = await BarcodeScanner.scan();
            setState(() {
              qrResult = scaning;
            });
            if (qrResult != '') {
              if (qrResult == aId) {
                final result = await ScanQR().scanqrRequest(sId, aId);
                print(result);
                if (result == 'Success') {
                  showSuccessDialog();
                } else if (result == 'Error') {
                  showNotActivityDialog();
                } else {
                  showDistrictDialog();
                }
              } else {
                showNotNameOnActivityDialog();
              }
            }
          },
          child: const Text('สแกน OR Code'),
        ),
      );
    }
  }

  void addIdDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'โปรดใส่รหัสนักศึกษาเพื่อเพิ่มนักศึกษาเข้ากิจกรรม',
                  style: TextStyle(fontSize: 16.0),
                ),
                verticalSpaceM,
                TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: 'เพิ่มรหัสนักศึกษา',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                        width: 2.0,
                      ),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                verticalSpaceM,
                InkWell(
                  onTap: () async {
                    if (controller.value != null) {
                      await InsertJoinActivity()
                          .insertJoinActivity(activity.a_id, controller.text);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        'ตกลง',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  splashColor: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogWidget(
          title: 'เข้าร่วมกิจกรรมสำเร็จ',
          subTitle: '',
          buttonTitle: 'ตกลง',
          color: Colors.green,
          iconData: Icons.check,
        );
      },
    );
  }

  void showDistrictDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogWidget(
            title: 'รายชื่อซ้ำ',
            subTitle: '',
            buttonTitle: 'ตกลง',
            color: Colors.yellow,
            iconData: Icons.warning);
      },
    );
  }

  void showNotActivityDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogWidget(
            title: 'ไม่ใช่กิจกรรมที่จะสแกน',
            subTitle: '',
            buttonTitle: 'ตกลง',
            color: Colors.yellow,
            iconData: Icons.warning);
      },
    );
  }

  void showNotNameOnActivityDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogWidget(
            title: 'ไม่มีรายชื่ออยู่ในกิจกรรมที่จะสแกน',
            subTitle: '',
            buttonTitle: 'ตกลง',
            color: Colors.yellow,
            iconData: Icons.warning);
      },
    );
  }
}
