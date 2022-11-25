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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
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
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ActivityManagement()),
                  );
                }),
          ],
          elevation: 0,
        ),
        body: Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
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
    var inputFormat = DateFormat('hh:mm');
    return Card(
      // color: Colors.pink,
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
        title: Text('จำนวนเข้าร่วม : ' + activity.a_qty),
        subtitle: Text('วันที่ : ' +
            Formatting.formatInBuddhistCalendarThai(activity.a_datestart)
                .toString() +
            '\t\tถึง\t\t' +
            Formatting.formatInBuddhistCalendarThai(activity.a_dateend)
                .toString() +
            '\nเวลา : ' +
            DateFormat.jm()
                .format(DateFormat("hh:mm").parse(activity.a_timestart)) +
            ' \t\tถึง\t\t' +
            DateFormat.jm()
                .format(DateFormat("hh:mm").parse(activity.a_timeend)) +
            ' '),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailsActivity(activity)),
          );
        },
      ),
    );
  }
}
