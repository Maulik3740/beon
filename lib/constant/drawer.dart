// lib/custom_drawer.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_ads_web/aboutUs.dart';
import 'package:super_ads_web/contact.dart';
import 'package:super_ads_web/home.dart';
import 'package:super_ads_web/policies.dart';
import 'package:super_ads_web/presskit.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late String name = '';
  double opacityBe = 0.0;
  double opacityO = 0.0;
  double opacityN = 0.0;

  @override
  void initState() {
    super.initState();
    _startOpacityAnimation();
    _loadUsername();
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

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = (prefs.getString('username') ?? '');
      print("Data from shared preference");
      print("$name....................");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: LinearBorder.none,
      width: 250,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.black,
            child: Container(
              height: 120,
              padding: EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(children: [
                    WidgetSpan(
                      child: AnimatedOpacity(
                        opacity: opacityBe,
                        duration: Duration(seconds: 1),
                        child: Text(
                          "Be",
                          style: GoogleFonts.poppins(fontSize: 40, color: Colors.white),
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
                          style: GoogleFonts.poppins(fontSize: 40, color: Colors.white),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.add_business_outlined),
            title: Text('Press'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => pressKit()));
            },
          ),
          ListTile(
            leading: Icon(Icons.content_paste_outlined),
            title: Text('Policies'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => Policies()));
            },
          ),
          ListTile(
            leading: Icon(Icons.perm_contact_calendar_outlined),
            title: Text('Contact'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => Contact()));
            },
          ),
          ListTile(
            leading: Icon(Icons.dashboard_customize_outlined),
            title: Text('About'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));
            },
          ),
          name.isEmptyOrNull
              ? Container()
              : ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Log Out'),
                  onTap: () async {
                    Navigator.pop(context);
                    SharedPreferences pref = await SharedPreferences.getInstance();
                    pref.remove("username");
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
                      return Home();
                    }));
                  },
                ),
        ],
      ),
    );
  }
}


//  RichText(
//                   text: TextSpan(children: [
//                     TextSpan(text: "Be", style: GoogleFonts.poppins(fontSize: 40, color: Colors.white)),
//                     TextSpan(text: "O", style: GoogleFonts.poppins(fontSize: 40, color: const Color.fromRGBO(12, 193, 254, 1))),
//                     TextSpan(
//                       text: "n",
//                       style: GoogleFonts.poppins(fontSize: 40, color: Colors.white),
//                     )
//                   ]),
//                 ),