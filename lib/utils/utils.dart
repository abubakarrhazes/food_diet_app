import 'package:flutter/material.dart';
import 'package:food_diet_app/providers/persistance_data/preferences.dart';
import 'package:food_diet_app/utils/color_constants.dart';

class Utils {
  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

//ShowError Dialog
  void showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          side: BorderSide(color: Colors.white),
        ),
        action: SnackBarAction(
          label: 'CLOSE',
          textColor: Colors.white,
          onPressed: () {
            scaffold.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void successShowToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          side: BorderSide(color: Colors.white),
        ),
        action: SnackBarAction(
          label: 'CLOSE',
          textColor: Colors.white,
          onPressed: () {
            scaffold.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void viewShowDialog(BuildContext context, String message,
      {bool isSuccess = true}) {
    Color dialogBackgroundColor = isSuccess ? Colors.green : Colors.red;
    Color titleColor = Colors.white;
    Color contentColor = Colors.black;
    Color buttonTextColor = Colors.white;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: dialogBackgroundColor,
          title: Text(
            isSuccess ? 'Success' : 'Error',
            style: TextStyle(color: titleColor),
          ),
          content: Text(
            message,
            style: TextStyle(color: contentColor),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, '/login');
              },
              child: Text(
                'OK',
                style: TextStyle(color: buttonTextColor),
              ),
            ),
          ],
        );
      },
    );
  }

  void logOutDialog(
    BuildContext context,
    String message,
  ) {
    Color dialogBackgroundColor = KprimaryColor;
    Color titleColor = Colors.white;
    Color contentColor = Colors.black;
    Color buttonTextColor = Colors.white;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: dialogBackgroundColor,
          title: Text(
            'Sign Out',
            style: TextStyle(color: titleColor),
          ),
          content: Text(
            message,
            style: TextStyle(color: titleColor),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () async {
                  final pref = await Preferences.getInstance();
                  pref.logOutUser(context);
                },
                child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: titleColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(child: Text('Yes')))),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: titleColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(child: Text('No')))),
          ],
        );
      },
    );
  }
}
