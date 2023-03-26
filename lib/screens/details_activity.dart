import 'package:barcode_scan/barcode_scan.dart';
import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectnan/api/get_join_activity.dart';
import 'package:projectnan/api/insert_join_activity.dart';
import 'package:projectnan/api/scan_qr_code_api.dart';
import 'package:projectnan/api/update_activity.dart';
import 'package:projectnan/model/activity.dart';
import 'package:projectnan/model/join_activity.dart';
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
  List<JoinActivity> joinactivity = [];
  String query = '';
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
    _loading = true;
    _getLogin();
    getJoinactivity();
  }

  Future getJoinactivity() async {
    final joinactivity =
        await GetJoinActivityapi.getJoinActivity(activity.a_id);

    setState(() {
      this.joinactivity = joinactivity;
      _loading = false;
    });
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
          : ListView(
              children: [
                _detailsactivity(context),
              ],
            )),
    );
  }

  Widget _detailsactivity(context) => Column(
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(12),
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
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  textActivityStatus(),
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
                  buttonOpenandStopActivity(),
                  verticalSpaceS,
                  tableStudent(),
                ],
              ),
            ),
          ),
        ],
      );

  Widget tableStudent() {
    if (p_Id != null) {
      return DataTable(
        columns: [
          DataColumn(
            label: Text(
              'รหัสนักศึกษา',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              'ชื่อนักศึกษา',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              'สถานะ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        rows: joinactivity.map((data) {
          return DataRow(
            cells: [
              DataCell(
                Text(
                  data.sId,
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              DataCell(
                Text(
                  data.sName,
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              DataCell(
                Text(
                  data.joinStatus,
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            ],
          );
        }).toList(),
      );
    } else {
      return Container();
    }
  }

  textActivityStatus() {
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

  textJoinActivityStatus(int status) {
    if (status == 0) {
      return Text(
        'ยังไม่ได้เข้าร่วมกิจกรรม',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      );
    } else if (status == 1) {
      return Text(
        'เข้าร่วมกิจกรรมแล้ว',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      );
    } else if (status == 2) {
      return Text(
        'ไม่ได้เข้าร่วมกิจกรรม',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      );
    } else {
      return Text(
        'สถานะ',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      );
    }
  }

  buttonOpenandStopActivity() {
    if (p_Id != null) {
      if (activity.a_status == '0') {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFFFEA18),
          ),
          onPressed: () async {
            await UpdateActivity().updateActivity(activity.a_id, 1);
            Navigator.pop(context, true);
            showSuccessDialog('เปิดกิจกรรมเรียบร้อย');
          },
          child: const Text(
            'เปิดกิจกรรม',
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                fontFamily: 'OpenSans'),
          ),
        );
      } else if (activity.a_status == '1') {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFFFEA18),
          ),
          onPressed: () async {
            await UpdateActivity().updateActivity(activity.a_id, 2);
            Navigator.pop(context, true);
            showSuccessDialog('ปิดกิจกรรมเรียบร้อย');
          },
          child: const Text(
            'ปิดกิจกรรม',
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                fontFamily: 'OpenSans'),
          ),
        );
      } else if (activity.a_status == '2') {
        return Container();
      } else {
        return Text('');
      }
    } else {
      return Container();
    }
  }

  Widget qrButton(String aId, String sId) {
    // print(_p_id);
    if (p_Id != null) {
      //ของเจ้าหน้าที่
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFFFEA18),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateQR(activity)),
              );
            },
            child: const Text(
              'สร้าง OR Code',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'OpenSans'),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFFFEA18),
            ),
            onPressed: () {
              addIdDialog();
            },
            child: const Text(
              'เพิ่มรหัสนักศึกษา',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'OpenSans'),
            ),
          ),
        ],
      );
    } else {
      //ของนักศึกษา
      return Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFFFEA18),
          ),
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
                  showSuccessDialog('เข้าร่วมกิจกรรมแล้ว');
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
          child: const Text(
            'สแกน OR Code',
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                fontFamily: 'OpenSans'),
          ),
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
                    // labelText: 'เพิ่มรหัสนักศึกษา',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey,
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
                      controller.clear();
                      setState(() {
                        getJoinactivity();
                      });
                      showSuccessDialog('เพิ่มรหัสนักศึกษาเรียบร้อย');
                    }
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Color(0xFFFFEA18),
                    ),
                    child: Center(
                      child: Text(
                        'ตกลง',
                        style: TextStyle(
                          color: Colors.black,
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

  void showSuccessDialog(String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogWidget(
          title: title,
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
