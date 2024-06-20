import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'dart:io' show Platform;

import 'package:super_ads_web/constant/Constant.dart';


dynamic buildToast(
    BuildContext context,
    String text, {
      ToastPosition? toastPosition,

      ///0 for 1 sec; 1 for 3 sec; 2 for 5 sec;
      int? priority,
    }) {
  priority = priority ?? 0;
  MediaQueryData mqd = MediaQuery.of(context);
  !kIsWeb
      ? ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: Platform.isIOS ? CupertinoColors.black : black,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(
        milliseconds: 1500,
      ),
      elevation: 0,
      padding: const EdgeInsets.fromLTRB(30, 15, 10, 15),
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 20 + mqd.viewPadding.bottom + mqd.padding.bottom / 2,
      ),
      behavior: SnackBarBehavior.floating,
    ),
  )
      : showToast(
    text,
    animationCurve: Curves.ease,
    context: context,
    position: toastPosition ?? ToastPosition.center,
    duration: Duration(
        milliseconds: priority == 2
            ? 5000
            : priority == 1
            ? 3000
            : 1000),
    radius: 5,
    backgroundColor: grey,
    textPadding: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 15,
    ),
    textStyle: const TextStyle(
      color: white,
      fontWeight: FontWeight.normal,
      letterSpacing: 1,
    ),
    dismissOtherToast: true,
  );
}
