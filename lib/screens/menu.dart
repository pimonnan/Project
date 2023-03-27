import 'package:flutter/material.dart';
import 'package:projectnan/api/personnel_api.dart';
import 'package:projectnan/api/student_api.dart';
import 'package:projectnan/model/personnel.dart';
import 'package:projectnan/model/student.dart';
import 'package:projectnan/screens/edit.dart';
import 'package:projectnan/screens/login_screen.dart';
import 'package:projectnan/untils/dialog_widget.dart';
import 'package:projectnan/widget/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  const Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  SharedPreferences sharedPreferences;
  String _username;
  String dm;
  String _pId;
  String _sId;
  String _bName;
  String _sName;
  List<Students> students = [];
  List<Personnel> personnel = [];
  final index = '';

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _getLogin();
  }

  _getLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String username = sharedPreferences.getString("username");
    final String depatrment = sharedPreferences.getString("dm");
    final String pId = sharedPreferences.getString("p_id");
    final String sId = sharedPreferences.getString("s_id");
    final String bName = sharedPreferences.getString("b");
    final String sName = sharedPreferences.getString("s_name");

    setState(() {
      _username = username;
      dm = depatrment;
      _pId = pId;
      _sId = sId;
      _bName = bName;
      _sName = sName;
    });
    String u = _username.substring(0, 1);
    if (u == 'P' || u == 'S') {
      //p ผู้ดูแล s นักเรียน
      _getProfile2(_pId);
    } else {
      _getProfile(_sId);
    }
  }

  _getProfile(String sId) async {
    //นักศึกษา
    final students = await Studentapi().getstudent(sId);

    setState(() => this.students = students);
    _loading = false;
    // print("students Page: ${students.length} item(s)");
  }

  _getProfile2(String pId) async {
    //เจ้าหน้าที่
    final personnel = await Personnelapi().getpersonnel(pId);

    setState(() => this.personnel = personnel);
    _loading = false;
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
            : _checkbuild()
        // ListView.builder(
        //     shrinkWrap: true,
        //     itemCount: students.length,
        //     itemBuilder: (context, index) {
        //       final student = students[index];
        //       return students.isNotEmpty
        //           ? _buildFrom(student)
        //           : const Text(
        //               'ไม่มีข้อมูล',
        //               style: TextStyle(fontSize: 24),
        //             );
        //     },
        //   ),
        );
  }

  _checkbuild() {
    //เช๋คดูว่าใครคือเจ้าหน้าที่ นักศึกษา
    String u = _username.substring(0, 1);
    if (u == 'P' || u == 'S') {
      //เจ้าหน้าที่
      return ListView.builder(
        shrinkWrap: true,
        itemCount: personnel.length,
        itemBuilder: (context, index) {
          final personnels = personnel[index];
          return personnel.isNotEmpty
              ? _buildFrom2(personnels)
              : const Text(
                  'ไม่มีข้อมูล',
                  style: TextStyle(fontSize: 24),
                );
        },
      );
    } else {
      return ListView.builder(
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
      );
    }
  }

  _buildFrom(Students student) {
    // ignore: unused_local_variable
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
                          // image: student.sImg != null
                          //     ? AssetImage("assets/pro.png")
                          //     : AssetImage(student.sImg),
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
                        children: <Widget>[
                          // _checktypeUser(student),
                          // _formpersonnel(personnel),
                          _formstudent(student)
                        ],
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

  _buildFrom2(Personnel personnel) {
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
                          // image: student.sImg != null
                          //     ? AssetImage("assets/pro.png")
                          //     : AssetImage(student.sImg),
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
                        children: <Widget>[
                          // _checktypeUser(student),
                          _formpersonnel(personnel),
                          // _formstudent(student)
                        ],
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

  _formpersonnel(Personnel personnel) {
    return _loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 16, left: 16, right: 16),
                        child: Text(
                          "ชื่อผู้ใช้ : " + '${personnel.pName}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 16, left: 16, right: 16),
                        child: Text(
                          "ไอดีผู้ใช้ : " + '${personnel.pId}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 16, left: 16, right: 16),
                        child: Text(
                          "ตำแหน่ง : " + '${personnel.dName}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 16, left: 16, right: 16),
                        child: Text(
                          "การศึกษา : " + '${personnel.pEducational}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ]),
          );
  }

  _formstudent(Students student) {
    String u = _username.substring(0, 1);
    // print(u);
    return _loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
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
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: Text(
                        "ชื่อผู้ใช้ : " + '${student.sName}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: Text(
                        "รหัสนักศึกษา : " + '${student.sId}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: Text(
                        "สาขา : " + '${_bName}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(top: 16, left: 16, right: 16),
                    //   child: Text(
                    //     "รหัสบัตรประชาชน : " + '${student.sCard}',
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.bold, fontSize: 18),
                    //   ),
                    // ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: Text(
                        "รุ่น : " + '${student.sGenaration}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: Text(
                        "กลุ่ม : " + '${student.sGroup}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }

  void _showLogoutAlertDialog() async {
    sharedPreferences = await SharedPreferences.getInstance();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            // title: Text("${sharedPreferences.getString("s_name")}"),
            content: Text("คุณต้องการออกจากระบบใช่หรือไม่ ?"),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xFFFFEA18)),
                onPressed: () {
                  sharedPreferences.clear();
                  sharedPreferences.commit();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()),
                      (route) => false);
                },
                child: Text(
                  "ตกลง",
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.3,
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.grey),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "ยกเลิก",
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.3,
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'OpenSans',
                  ),
                ),
              )
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
