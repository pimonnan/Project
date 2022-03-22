import 'package:flutter/material.dart';
import 'package:projectnan/api/student_api.dart';
import 'package:projectnan/model/student.dart';
import 'package:projectnan/screens/edit.dart';
import 'package:projectnan/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projectnan/widget/size_config.dart';

class Menu extends StatefulWidget {
  const Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  SharedPreferences sharedPreferences;
  String _username;
  String _dm;
  String _e_id;
  String _s_id;
  String _b_name;
  String _s_name;
  List<Students> students = [];

  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLogin();
  }

  _getLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String username = sharedPreferences.getString("username");
    final String depatrment = sharedPreferences.getString("dm");
    final String e_id = sharedPreferences.getString("e_id");
    final String s_id = sharedPreferences.getString("s_id");
    final String b_name = sharedPreferences.getString("b");
    final String s_name = sharedPreferences.getString("s_name");

    setState(() {
      _username = username;
      _dm = depatrment;
      _e_id = e_id;
      _s_id = s_id;
      _b_name = b_name;
      _s_name = s_name;
    });
    _loading = false;
    String u = _username.substring(0, 1);
    if (u == 'P' || u == 'S') {
    } else
      _getProfile(_s_id);
  }

  _getProfile(String s_id) async {
    final students = await Studentapi().getstudent(s_id);

    setState(() => this.students = students);
    // print("students Page: ${students.length} item(s)");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ตั้งค่า"),
        backgroundColor: Color(0xFFFFEA18),
        actions: [
          IconButton(
              icon: Icon(Icons.edit_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Edit()),
                );
              }),
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                _showLogoutAlertDialog();
              }),
        ],
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return students.isNotEmpty
                    ? _buildFrom(student)
                    : const Text(
                        'ไม่มีข้อมูล',
                        style: TextStyle(fontSize: 24),
                      );
              },
            ),
    );
  }

  _buildFrom(Students student) {
    double defaultSize = SizeConfig.defaultSize;
    return Column(
      children: <Widget>[
        SizedBox(
          height: 200,
          child: Stack(
            children: <Widget>[
              ClipPath(
                clipper: CustomShape(),
                child: Container(
                  height: 150,
                  color: Color(0xFFFFEA18),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.yellow[600],
                          width: 8,
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/pro.png"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            child: Form(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[_checktypeUser(student)],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _checktypeUser(Students student) {
    String u = _username.substring(0, 1);
    // print(u);
    if (u == 'P' || u == 'S') {
      return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: CircleAvatar(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Text(
                "ชื่อผู้ใช้ : " + '${_username}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Text(
                "ไอดีผู้ใช้ : " + '${_e_id}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Text(
                "ตำแหน่ง : " + '${_dm}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: 40.0,
            //   margin: EdgeInsets.only(top: 10),
            //   padding: EdgeInsets.symmetric(horizontal: 20.0),
            //   child: RaisedButton(
            //     color: Colors.redAccent,
            //     onPressed: () {
            //       setState(() {
            //         _showLogoutAlertDialog();
            //       });
            //     },
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(5.0),
            //     ),
            //     child: Text(
            //       "Logout",
            //       style: TextStyle(color: Colors.white70),
            //     ),
            //   ),
            // ),
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            //   child: CircleAvatar(
            //     radius: 50,
            //     child: Image.asset('assets/profileicon.png'),
            //     backgroundColor: Colors.transparent,
            //   ),
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Text(
                    "ชื่อผู้ใช้ : " + '${student.sName}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Text(
                    "รหัสนักศึกษา : " + '${student.sId}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Text(
                    "สาขา : " + '${_b_name}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Text(
                    "รหัสบัตรประชาชน : " + '${student.sCard}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Text(
                    "รุ่น : " + '${student.sGenaration}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Text(
                    "กลุ่ม : " + '${student.sGroup}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ],
            ),

            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: 40.0,
            //   margin: EdgeInsets.only(top: 10),
            //   padding: EdgeInsets.symmetric(horizontal: 20.0),
            //   child: RaisedButton(
            //     color: Colors.redAccent,
            //     onPressed: () {
            //       setState(() {
            //         _showLogoutAlertDialog();
            //       });
            //     },
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(5.0),
            //     ),
            //     child: Text(
            //       "Logout",
            //       style: TextStyle(color: Colors.white70),
            //     ),
            //   ),
            // ),
          ],
        ),
      );
    }
  }

  void _showLogoutAlertDialog() async {
    sharedPreferences = await SharedPreferences.getInstance();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("${sharedPreferences.getString("s_name")}"),
            content: Text("คุณต้องการออกจากระบบใช่หรือไม่ ?"),
            actions: [
              FlatButton(
                onPressed: () {
                  sharedPreferences.clear();
                  sharedPreferences.commit();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()),
                      (route) => false);
                },
                child: Text(
                  "ใช่",
                  style: TextStyle(
                      color: Colors.yellow[700], fontWeight: FontWeight.bold),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "ไม่",
                  style: TextStyle(
                      color: Colors.yellow[700], fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        });
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
