import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_ads_web/aboutUs.dart';
import 'package:super_ads_web/constant/Screen.dart';
import 'package:super_ads_web/contact.dart';
import 'package:super_ads_web/home.dart';
import 'package:super_ads_web/policies.dart';
import 'package:super_ads_web/presskit.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  double opacityBe = 0.0;
  double opacityO = 0.0;
  double opacityN = 0.0;

  @override
  void initState() {
    super.initState();
    _startOpacityAnimation();
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
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_rounded,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.black,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
            },
            child: Container(
              padding: EdgeInsets.all(10),
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
        ],
      ),
      actions: [
        s.width < 750
            ? Container()
            : Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "About",
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 20 * s.customWidth),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Contact()));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Contact",
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 20 * s.customWidth),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Policies()));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Policies",
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 20 * s.customWidth),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => pressKit()));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Press",
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
        s.width > 750
            ? Container()
            : Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
        SizedBox(width: 20),
      ],
    );
  }
}
