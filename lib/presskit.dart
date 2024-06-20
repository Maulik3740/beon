import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_ads_web/constant/Screen.dart';
import 'package:super_ads_web/constant/drawer.dart';
import 'package:super_ads_web/constant/navbar.dart';
import 'package:velocity_x/velocity_x.dart';

class pressKit extends StatelessWidget {
  const pressKit({super.key});

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: s.width > 750 ? null : CustomDrawer(),
      body: Stack(
        children: [
          //background
          Container(
            width: s.width,
            height: s.height,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), // Change to your desired color and opacity
                BlendMode.srcATop,
              ),
              child: Image.asset(
                'assets/lottie/bbb.webp',
                fit: BoxFit.cover,
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Text("Press Kit", style: GoogleFonts.poppins(fontSize: s.width < 700 ? 40 : 60, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 10, 113, 164))),
                ),
                Container(
                  // height: s.width < 1024 ? null : 250,
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 219, 237, 247),
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      s.width < 700
                          ? Container()
                          : Container(
                              width: s.width < 1020 ? 200 : 400 * s.customWidth,
                              color: Colors.amber,
                              child: Image.asset(
                                'assets/mylogo.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(text: 'Beon ', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' would like to ', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w400)),
                                    TextSpan(text: ' thank everyone', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' who took their time to feature the site.', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(text: 'If you need ', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w400)),
                                    TextSpan(text: 'awesome and creative content', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' for your platform, we\'re here to', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w400)),
                                    TextSpan(text: ' work with you!', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(text: 'Please send an email to ', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic)),
                                    TextSpan(text: 'contact@fuertedevelopers.in', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, decoration: TextDecoration.underline)),
                                    TextSpan(text: ' for more inquiries.', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: s.width < 700 ? 50 : 60,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text(
                    "DOWNLOADS",
                    style: GoogleFonts.poppins(fontSize: s.width < 700 ? 20 : 30, fontWeight: FontWeight.w500, color: const Color.fromARGB(255, 67, 132, 165)),
                  )),
                ),
              ],
            ).px(s.width < 700
                ? 20
                : s.width < 1024
                    ? 50
                    : 200),
          ),
        ],
      ),
    );
  }
}
