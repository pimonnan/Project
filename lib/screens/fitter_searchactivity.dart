import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projectnan/api/activity_api.dart';
import 'package:projectnan/model/activity.dart';
import 'package:projectnan/screens/activity_management.dart';
import 'package:projectnan/screens/details_activity.dart';
import 'package:projectnan/untils/constants.dart';
import 'package:projectnan/widget/search_widget.dart';
import 'package:intl/intl.dart';
import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';

class FitterSearchActiviy extends StatefulWidget {
  const FitterSearchActiviy({Key key}) : super(key: key);

  @override
  _FitterSearchActiviyState createState() => _FitterSearchActiviyState();
}

class _FitterSearchActiviyState extends State<FitterSearchActiviy> {
  List<Activity> activitys = [];
  String query = '';
  Timer debouncer;
  var Formatting = DateFormat('d MMM yyyy', 'th'); //วันที่ไทย
  bool isLoading = true;
  Activity activitySelected;
  var activitySelectedIndex = -1;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    int();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 500),
  }) {
    if (debouncer != null) {
      debouncer.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future int() async {
    final activitys = await Activityapi.getsearchactivity(query);

    setState(() {
      this.activitys = activitys;
      isLoading = false;
    });
    // setState(() => this.activitys = activitys);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1, //เพิ่ม tap
      child: Scaffold(
        appBar: AppBar(
          title: Text("งานกิจกรรม"),
          centerTitle: true,
          actions: [
            // IconButton(
            //     icon: Icon(Icons.add),
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) =>
            //                 ActivityManagement()), //หน้าเพิ่มกิจกรรม
            //       );
            //     }),
          ],
          elevation: 0,
        ),
        body: Column(
          children: <Widget>[
            buildSearch(),
            // Expanded(
            //   child: isLoading
            //       ? Center(
            //           child: CircularProgressIndicator(),
            //         )
            //       : ListView.builder(
            //           shrinkWrap: true,
            //           itemCount: activitys.length,
            //           itemBuilder: (context, index) {
            //             final activity = activitys[index];
            //             return activitys.isNotEmpty
            Expanded(child: buildActivitySection()),
            //       : const Text(
            //           'ไม่มีข้อมูล',
            //           style: TextStyle(fontSize: 24),
            //         );
            // },
            // ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: ' กรุณาป้อนชื่อกิจกรรม',
        onChanged: searchActivity,
      );

  Future searchActivity(String query) async => debounce(() async {
        final activitys = await Activityapi.getsearchactivity(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.activitys = activitys;
        });
      });

  Widget buildActivitySection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1.0),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: const [0.25, 0.75],
                colors: [Colors.yellow, Colors.white],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'กิจกรรม',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow,
                        radius: 16.0,
                        child: const Icon(Icons.add,
                            color: Colors.white, size: 22.0),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ActivityManagement()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 475,
              child: ListView.builder(
                //controller: categoryController,
                itemCount: activitys.length,
                scrollDirection: Axis.vertical,
                // physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  Activity activity = activitys[index];
                  return buildActivityItem(activity, index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildActivityItem(Activity activity, index) {
    double borderWidth = (activitySelectedIndex == index) ? 2.0 : 1.0;
    Color borderColor = (activitySelectedIndex == index)
        ? Colors.green[700]
        : Colors.transparent;

    return Material(
      child: InkWell(
        child: Container(
          height: 120.0,
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: Colors.yellow[100],
            border: Border.all(
              width: borderWidth,
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(3.0, 3.0),
                blurRadius: 3.0,
                spreadRadius: 0.5,
              )
            ],
          ),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: Text(
                    activity.a_name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text('จำนวน'),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.yellow[200],
                    borderRadius: BorderRadius.circular(10.0),
                    // border: Border.all(
                    //   color: Colors.black,
                    // ),
                  ),
                  child: Text(
                    activity.a_qty,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: Colors.yellow[200],
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: Text(
                        'วันที่ : ' +
                            Formatting.formatInBuddhistCalendarThai(
                                    activity.a_datestart)
                                .toString() +
                            '\t\tถึง\t\t' +
                            Formatting.formatInBuddhistCalendarThai(
                                    activity.a_dateend)
                                .toString(),
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 95.0),
                    Text('คน'),
                  ],
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          // setState(() {
          //   activitySelectedIndex = index;
          //   activitySelected = activity;
          // });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailsActivity(activity)),
          );
        },
      ),
    );
  }
}
