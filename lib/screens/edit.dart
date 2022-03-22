import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:projectnan/api/updatepassword.dart';
import 'package:projectnan/untils/constants.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Edit extends StatefulWidget {
  const Edit({Key key}) : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController passwordController = new TextEditingController();
  TextEditingController cpasswordController = new TextEditingController();
  TextEditingController bpasswordController = new TextEditingController();
  bool _passwordVisible = false;
  bool _loading = true;
  String _s_id;
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLogin();
  }

  _getLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String s_id = sharedPreferences.getString("s_id");

    setState(() {
      _s_id = s_id;
    });
    _loading = false;
    // String u = _username.substring(0, 1);
    // if (u == 'P' || u == 'S') {
    // } else
    //   _getProfile(_s_id);
  }

  updatePS(String s_id, String s_password, String b_password) {
    String v;
    UpdatePassword()
        .updatePasswordS(s_id, s_password, b_password)
        .then((value) {
      v = value;
      if (v == "Error") {
        _showDualog2();
        bpasswordController.clear();
        passwordController.clear();
        cpasswordController.clear();
      } else {
        Toast.show("แก้ไขรหัสผ่านสำเร็จ", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        bpasswordController.clear();
        passwordController.clear();
        cpasswordController.clear();
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // backgroundColor: Color(0xFFFFEF54),
        appBar: AppBar(
          title: Text("แก้ไขรหัสผ่าน"),
          centerTitle: true,
          elevation: 20,
        ),
        body: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 120.0,
            ),
            child:
                // Card(
                //   // color: Colors.transparent,
                //   shadowColor: Colors.black,
                //   elevation: 4,
                //   child:
                Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _buildPasswordBF(),
                _buildPasswordTF(),
                _buildConfrimPasswordTF(),
                _buildLoginBtn(),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }

  Widget _buildPasswordBF() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'รหัสผ่านเก่า',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                color: Colors.black),
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Color(0xFFFFE837),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            height: 60.0,
            child: TextFormField(
              controller: bpasswordController,
              obscureText: _passwordVisible,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
                  hintText: 'กรุณากรอกรหัสผ่านเก่า',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )),
              onSaved: (String value) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordTF() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'รหัสผ่านใหม่',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                color: Colors.black),
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Color(0xFFFFE837),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            height: 60.0,
            child: TextFormField(
              controller: passwordController,
              obscureText: _passwordVisible,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
                  hintText: 'กรุณากรอกรหัสผ่าน',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )),
              onSaved: (String value) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfrimPasswordTF() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'ยืนยันรหัสผ่านใหม่',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                color: Colors.black),
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Color(0xFFFFE837),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            height: 60.0,
            child: TextFormField(
              controller: cpasswordController,
              obscureText: _passwordVisible,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
                  hintText: 'กรุณากรอกรหัสผ่าน',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )),
              onSaved: (String value) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () {
            // print("Sucess");
            // Login(usernameController.text, passwordController.text);
            if (cpasswordController.text == '' ||
                passwordController.text == '') {
              passwordController.clear();
              cpasswordController.clear();
              _showDualog();
            } else if (passwordController.text != cpasswordController.text) {
              passwordController.clear();
              cpasswordController.clear();
              _showDualog();
            } else {
              updatePS(
                  _s_id, cpasswordController.text, bpasswordController.text);
            }
          },
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Color(0xFFFFEA18),
          child: Text(
            'ยืนยัน',
            style: TextStyle(
              color: Colors.black,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDualog() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('แก้ไขรหัสผ่านล้มเหลว'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(
                    "รหัสผ่านใหม่หรือหรือยืนยันรหัสผ่านใหม่ยังไม่ได้ระบุข้อความ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text("กรุณากรอกข้อมูลรหัสผ่านให้ครบถ้วนและยืนยันอีกครั้ง ค่ะ",
                      style: TextStyle(fontSize: 20))
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  child: Text("ยืนยัน"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  Future<void> _showDualog2() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('แก้ไขรหัสผ่านล้มเหลว'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(
                    "รหัสผ่านเก่าของคุณไม่ถูกต้อง",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text("กรุณากรอกข้อมูลรหัสผ่านให้ครบถ้วนและยืนยันอีกครั้ง ค่ะ",
                      style: TextStyle(fontSize: 20))
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  child: Text("ยืนยัน"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }
}
