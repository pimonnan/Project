import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectnan/model/activity.dart';
import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';
import 'package:projectnan/screens/create_qr_code.dart';
import 'package:projectnan/screens/scan_qr_code.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsActivity extends StatefulWidget {
  Activity activity;
  DetailsActivity(this.activity);

  @override
  State<DetailsActivity> createState() => _DetailsActivityState(activity);
}

class _DetailsActivityState extends State<DetailsActivity> {
  Activity activity;
  _DetailsActivityState(this.activity);
  var Formatting = DateFormat('d MMM yyyy', 'th'); //วันที่ไทย
  bool _loading = true;
  String _p_id;
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
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
          Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Image.network(
                'https://scontent.fbkk8-4.fna.fbcdn.net/v/t1.18169-9/268947_216414225067313_2210587_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=cdbe9c&_nc_eui2=AeHROxc_gKaeoCTLjio33ZFdJ6acQfibxfonppxB-JvF-lcWIK-UnjVZzQOlpesl4yBJBSwK-a3wsMOEhJR6KEet&_nc_ohc=LjLbCnseIiAAX8CCCtn&_nc_ht=scontent.fbkk8-4.fna&oh=00_AT_fqSkbKPBMVlcaw5EGzXc3uF4c4fjsQKsIVFXY1fMBrg&oe=62DC6C52',
                // width: 350,
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(8),
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
                    height: 20,
                  ),
                  Text(
                    'ชื่อคณะ : ' + activity.f_name,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
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
                  TextStatus(),
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
                            Formatting.formatInBuddhistCalendarThai(
                                    activity.a_datestart)
                                .toString() +
                            '\t\t',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        'ถึง : ' +
                            Formatting.formatInBuddhistCalendarThai(
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
                  SizedBox(
                    height: 16,
                  ),
                  // Text(_p_id),
                  QRbtn(),
                ],
              ),
            ),
          ),
        ],
      );

  TextStatus() {
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
    final String p_id = sharedPreferences.getString("p_id");

    setState(() {
      _p_id = p_id;
    });
  }

  Widget QRbtn() {
    // print(_p_id);
    if (_p_id != null) {
      //ของเจ้าหน้าที่
      return Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateQR(activity)),
            );
          },
          child: const Text('สร้าง OR Code'),
        ),
      );
    } else {
      //ของนักศึกษา
      return Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Scan()),
            );
          },
          child: const Text('สแกน OR Code'),
        ),
      );
    }
  }
}
