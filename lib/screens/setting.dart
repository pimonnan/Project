import 'package:flutter/material.dart';
import 'package:projectnan/screens/edit.dart';

class Setting extends StatefulWidget {
  const Setting({Key key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        ],
      ),
    );
  }
}
