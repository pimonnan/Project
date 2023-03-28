import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    Key key,
    this.title,
    this.subTitle,
    this.buttonTitle,
    this.iconData,
    this.color,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final String buttonTitle;
  final IconData iconData;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              size: 60.0,
              color: color,
            ),
            SizedBox(height: 16.0),
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              subTitle,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              child: Text(
                buttonTitle,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 24.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
