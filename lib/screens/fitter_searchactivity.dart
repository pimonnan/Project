import 'dart:async';

import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectnan/api/activity_api.dart';
import 'package:projectnan/model/activity.dart';
import 'package:projectnan/screens/activity_management.dart';
import 'package:projectnan/screens/details_activity.dart';
import 'package:projectnan/untils/space_widget.dart';
import 'package:projectnan/widget/search_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FitterSearchActiviy extends StatefulWidget {
  const FitterSearchActiviy({Key key}) : super(key: key);

  @override
  _FitterSearchActiviyState createState() => _FitterSearchActiviyState();
}

class _FitterSearchActiviyState extends State<FitterSearchActiviy> {
  List<Activity> activitys = [];
  String query = '';
  Timer debouncer;
  var formatting = DateFormat('d MMM yyyy', 'th'); //วันที่ไทย
  bool isLoading = false;
  Activity activitySelected;
  var activitySelectedIndex = -1;
  SharedPreferences sharedPreferences;
  String p_Id;
  String s_Id;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    getActivity();
    _getLogin();
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

  Future getActivity() async {
    final activitys = await Activityapi.getsearchactivity(query);

    setState(() {
      this.activitys = activitys;
      isLoading = false;
    });
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1, //เพิ่ม tap
      child: Scaffold(
        appBar: AppBar(
          title: Text("งานกิจกรรม"),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await getActivity();
              },
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: isLoading
              ? [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ]
              : <Widget>[
                  buildSearch(),
                  Expanded(
                    child: buildActivitySection(),
                  ),
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
                if (p_Id != null)
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
                          builder: (context) => const ActivityManagement(),
                        ),
                      ).then((value) => value != null ? getRefresh() : null);
                    },
                  ),
              ],
            ),
          ),
          verticalSpaceS,
          Expanded(
            child: Container(
              height: 500,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 350,
                    childAspectRatio: 3 / 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                //controller: categoryController,
                itemCount: activitys.length,
                scrollDirection: Axis.vertical,
                // physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final activityList = activitys.reversed.toList();
                  Activity activity = activityList[index];
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

    return Material(
      child: InkWell(
        child: Container(
          height: 120.0,
          padding: const EdgeInsets.all(8.0),
          // margin: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            // color: Colors.yellow[100],
            color: Color(0xFFFFE837),
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                verticalSpaceM,
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: Row(
                    children: [
                      Text(
                        'จำนวน',
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      horizontalSpaceS,
                      Text(
                        activity.a_qty,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                      horizontalSpaceS,
                      Text(
                        'คน',
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpaceS,
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        child: Text(
                          'วันที่ : \t\t\t\t' +
                              formatting
                                  .formatInBuddhistCalendarThai(
                                      activity.a_datestart)
                                  .toString() +
                              ' \nถึงวันที่ : ' +
                              formatting
                                  .formatInBuddhistCalendarThai(
                                      activity.a_dateend)
                                  .toString(),
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(width: 95.0),
                  ],
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsActivity(activity),
            ),
          ).then((value) => value != null ? getRefresh() : null);
        },
      ),
    );
  }

  getRefresh() async {
    setState(() {
      getActivity();
    });
  }
}
