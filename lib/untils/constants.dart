import 'package:flutter/material.dart';

final kHintTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFFFFEE4F),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

const apiurl =
    'https://9699-2405-9800-bca0-6c30-fc18-7df1-4ae9-d3b2.ap.ngrok.io';

// const apiurl = 'http://192.168.1.107';
const IconData manage_search = IconData(0xe3c7, fontFamily: 'MaterialIcons');
