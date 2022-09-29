import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projectnan/screens/fitter_searchactivity.dart';
// import 'package:projectnan/screens/activity.dart';
import 'package:projectnan/screens/homepage.dart';
import 'package:projectnan/screens/menu.dart';
import 'package:projectnan/screens/setting.dart';
import 'package:projectnan/untils/badgeIcon.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  int _tabBarCount = 0;
  List<Widget> pages;
  Widget currantpage;
  int count = 0;
  bool _loading;
  StreamController<int> _countController = StreamController<int>();
  Homepage homepage = new Homepage();
  FitterSearchActiviy fitterSearchActiviy = new FitterSearchActiviy();
  Menu menu = new Menu();
  //Setting setting = new Setting();

  // Activity activity = new Activity();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pages = [homepage, fitterSearchActiviy, menu];
    // pages = [homepage, menu];
    currantpage = homepage;

    // _loading = true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: currantpage,
      bottomNavigationBar: RefreshIndicator(
        child: SafeArea(
          child: ClipRRect(
            // borderRadius: BorderRadius.only(
            //   topLeft: Radius.circular(30.0),
            //   topRight: Radius.circular(30.0),
            // ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color(0xFFFFEA18),
              selectedItemColor: Colors.black, //เปลี่ยนสีตรงคลิก
              items: [
                BottomNavigationBarItem(
                  icon: StreamBuilder(
                    initialData: _tabBarCount,
                    stream: _countController.stream,
                    builder: (_, snapshot) => BadgeIcon(
                      icon: Icon(
                        Icons.home,
                      ),
                      badgeCount: snapshot.data,
                    ),
                  ),
                  title: const Text("หน้าแรก"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.assistant_photo),
                  title: Text("งานกิจกรรม"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings_applications_rounded),
                  title: Text("ตั้งค่า"),
                ),
              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                  currantpage = pages[index];
                });
              },
            ),
          ),
        ),
        onRefresh: _handleRefresh,
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    Completer<Null> completer = new Completer<Null>();

    new Future.delayed(new Duration(milliseconds: 5)).then((_) {
      completer.complete();
      // setState(() {
      //   _loading = true;
      //   initializing();
      //   Jsondata.getNew().then((_newss) {
      //     setState(() {
      //       _new = _newss;
      //       _loading = false;
      //       if (_new.isNotEmpty) {
      //         return _new.elementAt(0);
      //       }
      //       if (_new.length != 0) {
      //         _tabBarCount = _new.length;
      //         _countController.sink.add(_tabBarCount);
      //       } else {
      //         _tabBarCount = _new.length;
      //         _countController.sink.add(_tabBarCount);
      //       }
      //     });
      //   });
      // });
    });

    return null;
  }
}
