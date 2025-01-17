import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {

  static void showNeutralMessage(String message) => Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black45,
    toastLength: Toast.LENGTH_SHORT,
    textColor: Colors.black,
  );
}
