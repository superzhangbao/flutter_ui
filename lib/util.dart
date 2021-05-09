import 'dart:io';

import 'package:flutter/cupertino.dart';

FontWeight fontWeightBold() {
  if(Platform.isAndroid) {
    return FontWeight.w500;
  }else {
    return FontWeight.w600;
  }
}