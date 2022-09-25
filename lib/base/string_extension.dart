import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  showToast() {
    Fluttertoast.showToast(
      msg: this,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey.shade400.withOpacity(0.5),
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  int thousandFormatterToInt() {
    if (isNotEmpty) {
      return NumberFormat("#.###", "id_ID").parse(this).toInt();
    }
    return 0;
  }

  String getFirstWord() {
    List<String> wordList = split(" ");
    wordList.first;
    return "${wordList.first[0].toUpperCase()}${wordList.first.substring(1).toLowerCase()}";
  }
}
