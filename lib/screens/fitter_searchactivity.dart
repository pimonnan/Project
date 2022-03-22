import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projectnan/api/activity_api.dart';
import 'package:projectnan/model/activity.dart';
import 'package:projectnan/untils/constants.dart';
import 'package:projectnan/widget/search_widget.dart';
import 'package:intl/intl.dart';

class FitterSearchActiviy extends StatefulWidget {
  const FitterSearchActiviy({Key key}) : super(key: key);

  @override
  _FitterSearchActiviyState createState() => _FitterSearchActiviyState();
}

class _FitterSearchActiviyState extends State<FitterSearchActiviy> {
  List<Activity> activitys = [];
  String query = '';
  Timer debouncer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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

    setState(() => this.activitys = activitys);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("งานกิจกรรม"),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            indicatorWeight: 3,
            indicatorColor: Colors.grey[400], //สีเส้นใต้ล่าง
            tabs: [
              Tab(
                text: 'กิจกรรมทั้งหมด',
              ),
              Tab(
                text: 'กิจกรรมคณะวิทยาศาสตร์',
              ),
              Tab(
                text: 'กิจกรรมคณะการจัดการ',
              ),
            ],
          ),
          elevation: 20,
        ),
        body: Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
              child: TabBarView(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: activitys.length,
                    itemBuilder: (context, index) {
                      final activity = activitys[index];
                      return activitys.isNotEmpty
                          ? buildActivity(activity)
                          : const Text(
                              'ไม่มีข้อมูล',
                              style: TextStyle(fontSize: 24),
                            );
                    },
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: activitys.length,
                    itemBuilder: (context, index) {
                      final activity = activitys[index];
                      return activitys.isNotEmpty
                          ? buildActivity2(activity)
                          : const Text(
                              'ไม่มีข้อมูล',
                              style: TextStyle(fontSize: 24),
                            );
                    },
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: activitys.length,
                    itemBuilder: (context, index) {
                      final activity = activitys[index];
                      return activitys.isNotEmpty
                          ? buildActivity3(activity)
                          : const Text(
                              'ไม่มีข้อมูล',
                              style: TextStyle(fontSize: 24),
                            );
                    },
                  ),
                ],
              ),
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

  buildActivity(Activity activity) {
    var inputFormat = DateFormat('dd/MM/yyyy');
    return Card(
      elevation: 4,
      child: ListTile(
        leading: SizedBox(
          width: 100,
          child: Text(
            activity.a_name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            softWrap: false,
          ),
        ),
        title: Text('คณะ : ' + activity.f_name),
        subtitle: Text('วันที่ : ' +
            inputFormat.format(activity.a_datestart).toString() +
            '\t\tถึง\t\t' +
            inputFormat.format(activity.a_dateend).toString() +
            '\nเวลา : ' +
            activity.a_timestart +
            ' น.\t\tถึง\t\t' +
            activity.a_timeend +
            ' น.'),
        // trailing: IconButton(
        //   icon: const Icon(Icons.search),
        //   onPressed: () {
        //     print("search");
        //   },
        // ),
      ),
    );
  }

  buildActivity2(Activity activity) {
    var inputFormat = DateFormat('dd/MM/yyyy');
    if (activity.f_id == '1') {
      return Card(
        elevation: 4,
        child: ListTile(
          leading: SizedBox(
            width: 100,
            child: Text(
              activity.a_name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
            ),
          ),
          title: Text('คณะ : ' + activity.f_name),
          subtitle: Text('วันที่ : ' +
              inputFormat.format(activity.a_datestart).toString() +
              '\t\tถึง\t\t' +
              inputFormat.format(activity.a_dateend).toString() +
              '\nเวลา : ' +
              activity.a_timestart +
              ' น.\t\tถึง\t\t' +
              activity.a_timeend +
              ' น.'),
          // trailing: IconButton(
          //   icon: const Icon(Icons.search),
          //   onPressed: () {
          //     print("search");
          //   },
          // ),
        ),
      );
    }
  }

  buildActivity3(Activity activity) {
    var inputFormat = DateFormat('dd/MM/yyyy');
    if (activity.f_id == '2') {
      return Card(
        // color: Colors.blue[200],//ใส่สี
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                leading: SizedBox(
                  width: 100,
                  child: Text(
                    activity.a_name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
                title: Text('คณะ : ' + activity.f_name),
                subtitle: Text('วันที่ : ' +
                    inputFormat.format(activity.a_datestart).toString() +
                    '\t\tถึง\t\t' +
                    inputFormat.format(activity.a_dateend).toString() +
                    '\nเวลา : ' +
                    activity.a_timestart +
                    ' น.\t\tถึง\t\t' +
                    activity.a_timeend +
                    ' น.'),
                // trailing: IconButton(
                //   icon: const Icon(Icons.search),
                //   onPressed: () {
                //     print("search");
                //   },
                // ),
              ),
            ),
            // IconButton(icon: Icon(Icons.library_books), onPressed: () {}),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
