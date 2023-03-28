import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectnan/untils/constants.dart';
import 'package:projectnan/untils/dialog_widget.dart';
import 'package:projectnan/untils/space_widget.dart';
import 'package:projectnan/untils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';

class ActivityManagement extends StatefulWidget {
  const ActivityManagement({Key key}) : super(key: key);

  @override
  _ActivityManagementState createState() => _ActivityManagementState();
}

class _ActivityManagementState extends State<ActivityManagement> {
  TextEditingController nameActivityController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();
  TextEditingController detailsController = new TextEditingController();
  TextEditingController dateStarteController = new TextEditingController();
  TextEditingController dateEndController = new TextEditingController();
  TextEditingController timeStarteController = new TextEditingController();
  TextEditingController timeEndController = new TextEditingController();
  SharedPreferences sharedPreferences;
  var formatting = DateFormat('d MMM yyyy', 'th'); //วันที่ไทย
  final formKey = GlobalKey<FormState>();
  String dateStart;
  String dateEnd;

  Future<String> addActivity(
    String nameactivity,
    String quantity,
    String details,
    String datestart,
    String dateend,
    String timestart,
    String timeend,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var code = Random().nextInt(900); //แรนดอมไอดี
    var data = {
      'id': 'A$code',
      'pId': sharedPreferences.getString('p_id'),
      'nameactivity': nameactivity,
      'quantity': quantity,
      'details': details,
      'datestart': datestart,
      'dateend': dateend,
      'timestart': timestart,
      'timeend': timeend,
    };
    final response =
        await http.post(apiurl + '/Warehouse/addactivity.php', body: data);
    if (response.statusCode == 200) {
      Navigator.pop(context, true);
      // print(response.body);
      return response.body;
    } else {
      nameActivityController.clear();
      quantityController.clear();
      detailsController.clear();
      dateStarteController.clear();
      dateEndController.clear();
      timeStarteController.clear();
      timeEndController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // backgroundColor: Color(0xFFFFEF54),
        appBar: AppBar(
          title: Text("เพิ่มกิจกรรม"),
          centerTitle: true,
          elevation: 20,
        ),
        body: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _buildNameA(),
                  _buildQty(),
                  _buildDecription(),
                  _builddatestartanddateend(),
                  _buildstartandendtime(),
                  _buildLoginBtn(),
                ],
              ),
            ),
          ),
        ),
      ),
      // ),
    );
  }

  Widget _buildNameA() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ชื่อกิจกรรม',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                color: Colors.black),
          ),
          SizedBox(height: 5.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            height: 50.0,
            child: TextFormField(
              controller: nameActivityController,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 10.0),
                hintText: 'กรุณากรอกชื่อกิจกรรม',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontFamily: 'OpenSans',
                ),
              ),
              onSaved: (String value) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQty() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'จำนวนผู้เข้าร่วมกิจกรรม',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                color: Colors.black),
          ),
          SizedBox(height: 5.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            height: 50.0,
            child: TextFormField(
              controller: quantityController,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 10.0),
                hintText: 'กรุณากรอกจำนวนผู้เข้าร่วมกิจกรรม',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontFamily: 'OpenSans',
                ),
              ),
              onSaved: (String value) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecription() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'รายละเอียดกิจกรรม',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                color: Colors.black),
          ),
          SizedBox(height: 5.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            height: 50.0,
            child: TextFormField(
              controller: detailsController,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 10.0),
                hintText: 'กรุณากรอกรายละเอียดกิจกรรม',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontFamily: 'OpenSans',
                ),
              ),
              onSaved: (String value) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildstartandendtime() {
    final timeForm = TimeOfDay.now().to24Hours();
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'เวลาเริ่มต้น',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                    color: Colors.black),
              ),
              SizedBox(width: 102.0),
              Text(
                'เวลาสิ้นสุด',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                    color: Colors.black),
              ),
            ],
          ),
          verticalSpaceS,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                height: 50.0,
                width: 175,
                child: TextFormField(
                  controller: timeStarteController,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: timeForm,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10.0, top: 12),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.access_time_sharp),
                      tooltip: 'Tap to open date picker',
                      onPressed: () async {
                        final pickTimeS = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          builder: (context, childWidget) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: false),
                              child: childWidget,
                            );
                          },
                        );
                        if (pickTimeS != null) {
                          final formatTime = pickTimeS.format(context);
                          setState(() {
                            timeStarteController.text = formatTime;
                          });
                        } else {
                          setState(() {
                            timeStarteController.text = '';
                          });
                        }
                      },
                    ),
                  ),
                  onSaved: (String value) {},
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                height: 50.0,
                width: 175,
                child: TextFormField(
                  controller: timeEndController,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: timeForm,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 12.0, left: 10),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.access_time_sharp),
                      tooltip: 'Tap to open date picker',
                      onPressed: () async {
                        final pickTimeE = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          builder: (context, childWidget) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: false),
                              child: childWidget,
                            );
                          },
                        );
                        if (pickTimeE != null) {
                          final formatTime = pickTimeE.format(context);
                          setState(() {
                            timeEndController.text = formatTime;
                          });
                        } else {
                          setState(() {
                            timeEndController.text = '';
                          });
                        }
                      },
                    ),
                  ),
                  onSaved: (String value) {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _builddatestartanddateend() {
    final dateFrom =
        formatting.formatInBuddhistCalendarThai(DateTime.now()).toString();
    var dateEnd =
        formatting.formatInBuddhistCalendarThai(DateTime.now()).toString();
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'วันที่เริ่มกิจกรรม',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                    color: Colors.black),
              ),
              SizedBox(width: 59.0),
              Text(
                'ถึงวันที่',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                    color: Colors.black),
              ),
            ],
          ),
          verticalSpaceS,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                height: 50.0,
                width: 175,
                child: TextFormField(
                  controller: dateStarteController,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                  readOnly: true, //อ่านอย่างเดียว
                  decoration: InputDecoration(
                    hintText: dateFrom,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10.0, top: 12),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      tooltip: 'Tap to open date picker',
                      onPressed: () async {
                        final pickDateS = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2015, 8),
                          lastDate: DateTime(2101),
                        );
                        final formatDate = formatting
                            .formatInBuddhistCalendarThai(pickDateS)
                            .toString();
                        setState(() {
                          dateStart = pickDateS.toString();
                          dateStarteController.text = formatDate;
                        });
                      },
                    ),
                  ),
                  onSaved: (String value) {},
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                height: 50.0,
                width: 175,
                child: TextFormField(
                  controller: dateEndController,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                  readOnly: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10.0, top: 12),
                    hintText: dateEnd,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      tooltip: 'Tap to open date picker',
                      onPressed: () async {
                        final pickDateE = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2015, 8),
                          lastDate: DateTime(2101),
                        );
                        final formatDate = formatting
                            .formatInBuddhistCalendarThai(pickDateE)
                            .toString();
                        setState(() {
                          dateEnd = pickDateE.toString();
                          dateEndController.text = formatDate;
                        });
                      },
                    ),
                  ),
                  onSaved: (String value) {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () {
            if ((nameActivityController.text == '') ||
                (quantityController.text == '') ||
                (detailsController.text == '') ||
                (dateStarteController.text == '') ||
                (dateEndController.text == '') ||
                (timeStarteController.text == '') ||
                (timeEndController.text == '')) {
              showDistrictDialog('กรุณาป้อนข้อมูลให้ครบถ้วน');
            } else if (formKey.currentState.validate()) {
              addActivity(
                nameActivityController.text,
                quantityController.text,
                detailsController.text,
                dateStart,
                dateEnd,
                timeStarteController.text,
                timeEndController.text,
              );
            }
          },
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Color(0xFFFFEA18),
          child: Text(
            'ยืนยัน',
            style: TextStyle(
              color: Colors.black,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ),
    );
  }

  void showDistrictDialog(String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogWidget(
            title: title,
            subTitle: '',
            buttonTitle: 'ตกลง',
            color: Colors.yellow,
            iconData: Icons.warning);
      },
    );
  }
}

extension TimeOfDayConveter on TimeOfDay {
  String to24Hours() {
    final hour = this.hour.toString().padLeft(2, '0');
    final min = minute.toString().padLeft(2, '0');
    return '$hour:$min';
  }
}
