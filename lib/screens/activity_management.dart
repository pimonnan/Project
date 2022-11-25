import 'package:flutter/material.dart';

class ActivityManagement extends StatefulWidget {
  const ActivityManagement({Key key}) : super(key: key);

  @override
  _ActivityManagementState createState() => _ActivityManagementState();
}

class _ActivityManagementState extends State<ActivityManagement> {
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
            padding: EdgeInsets.symmetric(
              // horizontal: 40.0,//เปลี่ยนพื้นที่ว่าง
              vertical: 40.0, //เปลี่ยนพื้นที่ว่าง
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
                _buildNameA(),
                _buildQty(),
                _buildDecription(),
                _builddatestart(),
                _builddateend(),
                _buildstaretime(),
                _buildendtime(),
                _buildLoginBtn(),
              ],
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
        children: <Widget>[
          Text(
            'ชื่อกิจกรรม',
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
              color: Colors.white,
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
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 14.0),
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
        children: <Widget>[
          Text(
            'จำนวนผู้เข้าร่วมกิจกรรม',
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
              color: Colors.white,
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
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 14.0),
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
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
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
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 14.0),
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

  Widget _builddatestart() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'วันที่เริ่มกิจกรรม',
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
              color: Colors.white,
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
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                // contentPadding: EdgeInsets.only(top: 14.0),
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  tooltip: 'Tap to open date picker',
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101),
                    );
                  },
                ),
              ),
              onSaved: (String value) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _builddateend() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'ถึงวันที่',
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
              color: Colors.white,
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
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                // contentPadding: EdgeInsets.only(top: 14.0),
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  tooltip: 'Tap to open date picker',
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101),
                    );
                  },
                ),
              ),
              onSaved: (String value) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildstaretime() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'เวลาเริ่มต้น',
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
              color: Colors.white,
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
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                // contentPadding: EdgeInsets.only(top: 14.0),
                hintText: 'กรุณากรอกรายละเอียดกิจกรรม',
                hintStyle: TextStyle(
                  color: Colors.black,
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

  Widget _buildendtime() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'เวลาสิ้นสุด',
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
              color: Colors.white,
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
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                // contentPadding: EdgeInsets.only(top: 14.0),
                hintText: 'กรุณากรอกรายละเอียดกิจกรรม',
                hintStyle: TextStyle(
                  color: Colors.black,
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
            // if (cpasswordController.text == '' ||
            //     passwordController.text == '') {
            //   // passwordController.clear(); //ให้รหัสผ่านอยู่ที่เดิม
            //   // cpasswordController.clear();
            //   _showDualog();
            // } else if (passwordController.text != cpasswordController.text) {
            //   // passwordController.clear(); //ให้รหัสผ่านอยู่ที่เดิม
            //   // cpasswordController.clear();
            //   _showDualog();
            // } else {
            //   updatePS(
            //       _s_id, cpasswordController.text, bpasswordController.text);
            // }
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
              fontWeight: FontWeight.normal,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ),
    );
  }
}
