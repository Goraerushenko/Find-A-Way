
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


ScreenManage screenManage;

class ScreenManage {

  final MediaQueryData data;

  ScreenManage(
    this.data,
  );


  double get padding => data.padding.top;

  double get height => data.size.height;

  double get weight => data.size.width;
}