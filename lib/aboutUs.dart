import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_ads_web/constant/Screen.dart';
import 'package:super_ads_web/constant/drawer.dart';
import 'package:super_ads_web/constant/navbar.dart';
import 'package:velocity_x/velocity_x.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text("About Us", style: GoogleFonts.poppins(fontSize: s.width < 700 ? 35 : 50, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 10, 113, 164))),
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("The Start of Journey", style: GoogleFonts.poppins(fontSize: s.width < 700 ? 25 : 30, color: Color.fromARGB(255, 10, 113, 164))),
                  ),
                  Container(
                    // height: s.width < 1024 ? null : 250,
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 219, 237, 247),
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        boxText('beon started as a combination of some downtime created by the coronavirus and my desire to give back to the eCom community that has given me so much.', s),
                        SizedBox(height: 10),
                        boxText('Bills of lading are public information that every large eCom or supply chain professional I know uses but they are too cost prohibitive, challenging to obtain and difficult to use for the average joe. Beon\'s goal is to solve that problem.', s)
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 300,
                          decoration: BoxDecoration(
                            border: Border.all(width: 5, color: Colors.black38),
                          ),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "14,921",
                                style: TextStyle(fontSize: 50, color: Colors.blue),
                              ),
                              Text("# of Raving Fans"),
                            ],
                          )),
                        ),
                      ),
                      SizedBox(width: s.width < 700 ? 0 : 20),
                      s.width < 700
                          ? Container()
                          : Expanded(
                              child: Container(
                                height: 300,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 5, color: Colors.black38),
                                ),
                                child: Image.asset(
                                  'assets/map.png',
                                  fit: BoxFit.fill,
                                ).px24(),
                              ),
                            ),
                    ],
                  ),
                  SizedBox(height: s.width < 700 ? 20 : 0),
                  s.width > 700
                      ? Container()
                      : Container(
                          height: 300,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 5, color: Colors.grey.shade300),
                          ),
                          child: Image.asset(
                            'assets/map.png',
                            fit: BoxFit.fill,
                          ).px24(),
                        ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Our Destination", style: GoogleFonts.poppins(fontSize: s.width < 700 ? 25 : 30, color: Color.fromARGB(255, 10, 113, 164))),
                  ),
                  Container(
                    // height: s.width < 1024 ? null : 250,
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 219, 237, 247),
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        boxText('We try to remain flexible in the way we think about the future, but our current roadmap is based on a few thoughts (all thoughts and feedback on our direction are welcome):', s),
                        SizedBox(height: 10),
                        boxText('1) Core Beon will always remain free.', s),
                        SizedBox(height: 10),
                        boxText('2) The supply chain space has a very slow idea diffusion rate. If we are going to succeed, we need to continue spreading Beon and converting people who use it into raving fans. If we have 5,000,000 people a month on the site and 100,000 raving fans, many problems are easier to solve.', s),
                        SizedBox(height: 10),
                        boxText('3) From talking with 5,000+ users, there is a lot of opportunity to create paid applications on top of core Beon to solve problems in the sales prospecting, economic development, supply chain risk assessment and ESG spaces.', s),
                        SizedBox(height: 10),
                        boxText('4) There is a lot of opportunity to help our users make better supply chain decisions around complex issues like choosing freight forwarders, payment providers, the right suppliers, etc.', s),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text("We want to hear your thoughts...", style: GoogleFonts.poppins(fontSize: s.width < 700 ? 25 : 30, color: Color.fromARGB(255, 10, 113, 164))),
                        boxText('If you enjoyed Beon or have any ideas for how to improve it, I want to hear from you.', s),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: 'My LinkedIn handle is  ',
                            style: GoogleFonts.poppins(
                              fontSize: s.width < 700 ? 14 : 16,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 7, 60, 87),
                            ),
                          ),
                          TextSpan(
                            text: 'Beon',
                            style: GoogleFonts.poppins(
                              fontSize: s.width < 700 ? 14 : 18,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 37, 179, 250),
                              decoration: TextDecoration.underline,
                              decorationColor: Color.fromARGB(255, 37, 179, 250),
                            ),
                          ),
                        ])),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              width: s.width > 700 ? 200 : 120,
                              height: s.width > 700 ? 200 : 120,
                              child: Image.asset(
                                'assets/5.jpg',
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Aditya Prakash",
                                    style: GoogleFonts.poppins(fontSize: s.width > 700 ? 20 : 16, fontWeight: FontWeight.w400),
                                  ),
                                  Text("Founder, Beon", style: GoogleFonts.poppins(fontSize: s.width > 700 ? 20 : 16, fontWeight: FontWeight.w400)),
                                  Text("contact@fuertedevelopers.in", style: GoogleFonts.poppins(fontSize: s.width > 700 ? 20 : 16, fontWeight: FontWeight.w400, color: Colors.blueAccent)),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ).px(s.width < 700
                  ? 20
                  : s.width < 1024
                      ? 50
                      : 350),
            ),
          ),
        ],
      ),
    );
  }

  Widget boxText(String text, Screen s) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: s.width < 700 ? 14 : 16,
        fontWeight: FontWeight.w400,
        color: Color.fromARGB(255, 7, 60, 87),
      ),
    );
  }
}
