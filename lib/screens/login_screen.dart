import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectnan/screens/home.dart';
import 'package:projectnan/untils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:projectnan/untils/dialog_widget.dart';
import 'package:projectnan/untils/utils.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool _passwordVisible;
  SharedPreferences sharedPreferences;

  Future<String> Login(String username, String password) async {
    Map data = {
      'username': username,
      'password': password,
    };
    // final response = await http.post(apiurl + '/login.php', body: data);
    final response =
        await http.post(apiurl + '/Warehouse/login.php', body: data);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonData;
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);

      sharedPreferences.setString("username", username);
      if (jsonData['p_id'] != null) {
        sharedPreferences.setString("dm", jsonData['d_name']);
        sharedPreferences.setString("p_id", jsonData['p_id']);
      } else {
        sharedPreferences.setString("b", jsonData['b_name']);
        sharedPreferences.setString("s_id", jsonData['s_id']);
        sharedPreferences.setString("s_name", jsonData['s_name']);
      }
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  Home()), //เป็นการเชื่อมหน้าต่อไป
          (route) => false);

      return response.body;
    } else if ((usernameController.text == '') ||
        (passwordController.text == '')) {
      showDistrictDialog('กรุณาป้อนข้อมูลให้ครบถ้วน');
    } else {
      usernameController.clear();
      passwordController.clear();
      showDistrictDialog('ชื่อผู้ใช้และรหัสผ่านไม่ถูกต้อง');
    }
  }

  Widget _buildUsernameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'ชื่อผู้ใช้',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: usernameController,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.yellow[900],
              ),
              hintText: 'กรุณากรอกชื่อผู้ใช้',
              hintStyle: kHintTextStyle,
            ),
            onSaved: (String value) {},
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'รหัสผ่าน',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
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
                color: Colors.yellow[900],
              ),
              hintText: 'กรุณากรอกรหัสผ่าน',
              hintStyle: kHintTextStyle,
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off, //ไอคอนเปิดปิด
                  color: Colors.yellow[900],
                  // color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  //กดเช็คปุ่มเปิดปิด
                  setState(() {
                    // Future.delayed(Duration(milliseconds: 300), () {
                    _passwordVisible = !_passwordVisible;
                    // });
                  });
                },
              ),
            ),
            onSaved: (String value) {},
          ),
        ),
      ],
    );
  }

  void resetPassword() {
    setState(() {
      _passwordVisible = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = true; //เปลี่ยนจาก false เป็น true
  }

  void showSuccessDialog(String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogWidget(
          title: title,
          subTitle: '',
          buttonTitle: 'ตกลง',
          color: Colors.green,
          iconData: Icons.check,
        );
      },
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

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          // print("Sucess");
          Login(usernameController.text, passwordController.text);
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Color(0xFFFFE837), //กรอบสีเหลี่ยม
        child: Text(
          'เข้าสู่ระบบ',
          style: TextStyle(
            color: Colors.black, //สีตัวอักษร
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFFBE04),
                      Color(0xFFFFBE04),
                      Color(0xFFFFBE04),
                      Color(0xFFFFBE04),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 70.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/logo2.png",
                        height: 250,
                      ),
                      Container(
                        child: Text(
                          'การเข้าร่วมกิจกรรมของนักศึกษาผ่าน QR CODE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildUsernameTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(),
                      _buildLoginBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
