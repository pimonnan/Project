import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplasdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//หน้าจอหลัก
// Color text
    const colorizeColors = [
      Colors.black,
      Colors.yellow,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 25.0,
      fontFamily: 'Lato',
    );

    return Scaffold(
      backgroundColor: Color(0xFFFFBE04),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/logo2.png',
              // color: Colors.white,
              height: 300,
            ),
            SizedBox(
              height: 10,
            ),
            // need an animated text
            AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'การเข้าร่วมกิจกรรมของนักศึกษาผ่าน QR CODE',
                  textAlign: TextAlign.center,
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
              ],
              isRepeatingAnimation: true,
              onTap: () {
                print("Tap Event");
              },
            ),
            SizedBox(
              height: 10,
            ),
            CircularProgressIndicator(
              backgroundColor: Colors.greenAccent[700],
            ), // ตัวหมุนตอนโหลด
          ],
        ),
      ),
    );
  }
}
