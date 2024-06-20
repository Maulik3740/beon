import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_ads_web/constant/drawer.dart';
import 'package:super_ads_web/constant/navbar.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:super_ads_web/constant/Screen.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key});

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

          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16.0),
              // color: Colors.amber,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container 1: Centered text with label and subtext
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      children: [
                        Text(
                          'Say Hello,',
                          style: GoogleFonts.poppins(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Whether it\'s product related or something you would like to share about your day, we\'re always here to listen. We love to hear from you!',
                          style: GoogleFonts.poppins(
                            fontSize: 18.0,
                            color: Color.fromARGB(255, 51, 91, 111),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: (s.width < 700 ? 0 : 20) * s.customHeight),
                  // Container 2: Divided into two parts with text
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              TeamSection(
                                image: Image.asset('assets/5.jpg'),
                                teamMembers: [
                                  'Aditya Prakash',
                                ],
                                teamName: ' Founder, Beon',
                                Name: 'Aditya Prakash',
                                email: 'contact@fuertedevelopers.in',
                                description: 'I\'d love to hear your thoughts, ideas, complaints, or anything in between. I receive a ton of emails, so please bear with me if my response may be delayed.',
                              ),
                              SizedBox(height: (s.width < 700 ? 50 : 0) * s.customHeight),
                              s.width > 700
                                  ? Container()
                                  : TeamSection(
                                      Name: 'Pooja Gangwani',
                                      teamMembers: [
                                        'Pooja Gangwani',
                                      ],
                                      teamName: 'Co Founder, Beon',
                                      image: Image.asset('assets/p.jpeg'),
                                      email: 'contact@fuertedevelopers.in',
                                      description: 'We\'re here to lend a hand or answer any questions about our site. We strive to get back to you asap!',
                                    )
                            ],
                          ),
                        ),
                        s.width < 700
                            ? Container()
                            : Container(
                                height: s.height / 1.6, // Specify the height
                                child: VerticalDivider(color: Colors.grey, width: 10),
                              ),
                        s.width < 700
                            ? Container()
                            : Expanded(
                                child: TeamSection(
                                  image: Image.asset('assets/p.jpeg'),
                                  Name: 'Pooja Gangwani',
                                  teamMembers: [
                                    'Pooja Gangwani',
                                  ],
                                  teamName: 'Co Founder, Beon',
                                  email: 'contact@fuertedevelopers.in',
                                  description: 'We\'re here to lend a hand or answer any questions about our site. We strive to get back to you asap!',
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TeamSection extends StatelessWidget {
  final List<String> teamMembers;
  final String teamName;
  final String Name;
  final String email;
  final String description;
  final Image? image;

  TeamSection({
    Key? key,
    required this.teamMembers,
    required this.teamName,
    required this.Name,
    required this.email,
    required this.description,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: image?.image ?? AssetImage('assets/9.png'),
        ),
        SizedBox(height: 10 * s.customHeight),
        Text(
          teamMembers.join(', '),
          style: GoogleFonts.poppins(
            fontSize: 18.0,
            color: Color.fromARGB(255, 51, 91, 111),
          ),
        ),
        Text(
          teamName,
          style: GoogleFonts.poppins(
            fontSize: 18.0,
            color: Color.fromARGB(255, 51, 91, 111),
          ),
        ),
        SizedBox(height: 40 * s.customHeight),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello ',
              style: GoogleFonts.poppins(
                fontSize: 18.0,
                color: Color.fromARGB(255, 51, 91, 111),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              Name,
              style: GoogleFonts.poppins(
                fontSize: 18.0,
                color: Colors.lightBlueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '!',
              style: GoogleFonts.poppins(
                fontSize: 18.0,
                color: Color.fromARGB(255, 51, 91, 111),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 5 * s.customHeight),
        Text(
          description,
          style: GoogleFonts.poppins(
            fontSize: 16.0,
            color: Color.fromARGB(255, 51, 91, 111),
          ),
          textAlign: TextAlign.center,
        ).px(120 * s.customWidth),
        SizedBox(height: 40 * s.customHeight),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.mail,
              color: Colors.lightBlueAccent,
            ),
            SizedBox(width: 10),
            Text(
              email,
              style: GoogleFonts.poppins(
                fontSize: 18.0,
                color: Color.fromARGB(255, 51, 91, 111),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
