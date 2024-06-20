import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_ads_web/Admin/Myapp.dart';
import 'package:super_ads_web/Admin/ViewDriverStatus.dart';
import 'package:super_ads_web/Admin/viewdriver.dart';
import 'package:super_ads_web/Login/phoneAuth.dart';
import 'package:super_ads_web/constant/Constant.dart';
import 'package:super_ads_web/constant/Screen.dart';
import 'package:super_ads_web/home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: s.isDesktop
          ? null
          : AppBar(
              automaticallyImplyLeading: false,
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.black,
              title: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
                },
                child: Row(
                  children: [
                    Text(
                      "SUPER ",
                      style: GoogleFonts.aBeeZee(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: red),
                    ),
                    Text(
                      "ADS",
                      style: GoogleFonts.aBeeZee(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: red),
                    ),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () async {
                      _showDialog(context);
                    },
                    child: Icon(
                      MdiIcons.logout,
                      color: white,
                    ),
                  ),
                ),
              ],
            ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // adminHeader(context: context),
            s.isDesktop ? adminHeader(context: context) : SizedBox.shrink(),

            Container(
              height: MediaQuery.of(context).size.height * 0.92,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      opacity: 0.3,
                      image: AssetImage('assets/lottie/bbb.webp'))),
              child: s.isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildGestureDetector(context,
                            title: "ADS User", viwe: "User"),
                        SizedBox(height: 20),
                        _buildGestureDetector(context,
                            title: "Leads Status", viwe: "Status"),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildGestureDetector(context,
                            title: "ADS User", viwe: "User"),
                        SizedBox(height: 20),
                        _buildGestureDetector(context,
                            title: "Leads Status", viwe: "Status"),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }

  void _navigateToViewDriver(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewDriver(),
      ),
    );
  }

  void _navigateToViewDriverStatus(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewDriverStatus(),
      ),
    );
  }

  Widget _buildGestureDetector(BuildContext context,
      {required String title, required String viwe}) {
    return GestureDetector(
      onTap: () {
        title == "ADS User"
            ? _navigateToViewDriver(context)
            : _navigateToViewDriverStatus(context);
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.30,
        width: 350,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.aBeeZee(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: Container(
                  // Adjust the height as needed
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.black,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.055,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: () {
                            title == "ADS User"
                                ? _navigateToViewDriver(context)
                                : _navigateToViewDriverStatus(context);
                          },
                          child: Text(
                            "View $viwe",
                            style: GoogleFonts.aBeeZee(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class adminHeader extends StatelessWidget {
  const adminHeader({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
                },
                child: Row(
                  children: [
                    Text(
                      "SUPER ",
                      style: GoogleFonts.bebasNeue(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: green),
                    ),
                    Text(
                      "ADS",
                      style: GoogleFonts.bebasNeue(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: green),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 40 * s.customWidth,
          ),
          SizedBox(
            width: 40 * s.customWidth,
          ),
          Icon(
            MdiIcons.chatPlus,
            color: white,
          ),
          SizedBox(
            width: 40 * s.customWidth,
          ),
          Icon(
            MdiIcons.phone,
            color: white,
          ),
          SizedBox(
            width: 40 * s.customWidth,
          ),
          Icon(
            MdiIcons.cog,
            color: white,
          ),
          SizedBox(
            width: 40 * s.customWidth,
          ),
          Row(
            children: [
              Text(
                "Super Ads",
                style: TextStyle(color: white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            width: 40 * s.customWidth,
          ),
          CircleAvatar(
            radius: 13,
            backgroundColor: Colors.grey.shade300,
            child: Icon(
              MdiIcons.accountMultiple,
              color: dark,
              size: 12,
            ),
          ),
          SizedBox(
            width: 5 * s.customWidth,
          ),
          GestureDetector(
            onTap: () async {},
            child: Text(
              "Admin",
              style: TextStyle(color: white, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 20 * s.customWidth,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () async {
                _showDialog(context);
              },
              child: Icon(
                MdiIcons.logout,
                color: white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _showDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: dark,
        title: Text(
          'Are you want to logout?',
          style: GoogleFonts.aBeeZee(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: red),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              var sharePref = await SharedPreferences.getInstance();
              sharePref.setBool(MyAppState.KEYLOGIN, false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
              // Navigator.of(context).pop(); // Close the dialog
              // Handle 'Yes' button click
              // Add your logic here
            },
            child: Text(
              'Yes',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              // Handle 'No' button click
              // Add your logic here
            },
            child: Text(
              'No',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    },
  );
}
