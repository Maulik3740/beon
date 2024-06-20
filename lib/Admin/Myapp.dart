import 'dart:async';
import 'dart:io' show kIsWeb;
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_ads_web/Admin/HomeScreen.dart';
import 'package:super_ads_web/Login/phoneAuth.dart';
import 'package:super_ads_web/constant/Constant.dart';
import 'package:super_ads_web/constant/Screen.dart';
import 'package:super_ads_web/home.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  static String KEYLOGIN = "login";
  double opacityBe = 0.0;
  double opacityO = 0.0;
  double opacityN = 0.0;

  @override
  void initState() {
    super.initState();
    _startOpacityAnimation();
    whereToGo();
  }

  void _startOpacityAnimation() {
    Timer(Duration(seconds: 1), () {
      setState(() {
        opacityBe = 1.0;
      });
    });

    Timer(Duration(seconds: 2), () {
      setState(() {
        opacityO = 1.0;
      });
    });

    Timer(Duration(seconds: 3), () {
      setState(() {
        opacityN = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: s.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                opacity: 0.3,
                image: AssetImage('assets/lottie/bbb.webp'),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: kIsWeb ? MediaQuery.of(context).size.height * 0.1 : MediaQuery.of(context).size.height * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Image(
                    //   image: AssetImage('assets/lottie/ads.gif'),
                    //   width: MediaQuery.of(context).size.width * 0.5,
                    //   height: MediaQuery.of(context).size.height * 0.5,
                    // )
                    s.isDesktop
                        ? Center(
                            child: RichText(
                              text: TextSpan(children: [
                                WidgetSpan(
                                  child: AnimatedOpacity(
                                    opacity: opacityBe,
                                    duration: Duration(seconds: 1),
                                    child: Text(
                                      "Be",
                                      style: GoogleFonts.poppins(fontSize: 80, color: Colors.black),
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  child: AnimatedOpacity(
                                    opacity: opacityO,
                                    duration: Duration(seconds: 1),
                                    child: Text(
                                      "O",
                                      style: GoogleFonts.poppins(fontSize: 80, color: const Color.fromRGBO(12, 193, 254, 1)),
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  child: AnimatedOpacity(
                                    opacity: opacityN,
                                    duration: Duration(seconds: 1),
                                    child: Text(
                                      "n",
                                      style: GoogleFonts.poppins(fontSize: 80, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          )
                        : Center(
                            child: RichText(
                              text: TextSpan(children: [
                                WidgetSpan(
                                  child: AnimatedOpacity(
                                    opacity: opacityBe,
                                    duration: Duration(seconds: 1),
                                    child: Text(
                                      "Be",
                                      style: GoogleFonts.poppins(fontSize: 40, color: Colors.black),
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  child: AnimatedOpacity(
                                    opacity: opacityO,
                                    duration: Duration(seconds: 1),
                                    child: Text(
                                      "O",
                                      style: GoogleFonts.poppins(fontSize: 40, color: const Color.fromRGBO(12, 193, 254, 1)),
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  child: AnimatedOpacity(
                                    opacity: opacityN,
                                    duration: Duration(seconds: 1),
                                    child: Text(
                                      "n",
                                      style: GoogleFonts.poppins(fontSize: 40, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          )
                  ],
                ),
                SizedBox(
                  height: kIsWeb ? MediaQuery.of(context).size.height * 0.1 : MediaQuery.of(context).size.height * 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> whereToGo() async {
    var sharePref = await SharedPreferences.getInstance();
    var isLogin = sharePref.getBool(KEYLOGIN);
    String phone = sharePref.getString('myphone') ?? '';
    Timer(Duration(seconds: 4), () {
      if (isLogin != null) {
        if (isLogin) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
        }
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
      }
    });
  }
}
