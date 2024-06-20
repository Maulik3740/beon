import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_ads_web/Login/phoneAuth.dart';
import 'package:super_ads_web/aboutUs.dart';
import 'package:super_ads_web/constant/Screen.dart';
import 'package:super_ads_web/constant/drawer.dart';
import 'package:super_ads_web/contact.dart';
import 'package:super_ads_web/policies.dart';
import 'package:super_ads_web/presskit.dart';
import 'package:super_ads_web/result.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:async';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double opacityBe = 0.0;
  double opacityO = 0.0;
  double opacityN = 0.0;

  late String name = '';

  late bool visible = false;
  late bool signButton = false;
  late List<bool> footer;

  TextEditingController searchController = TextEditingController();

  String textFieldValue = '';

  int? tappedIndex;

  void OnTapMenu(int index) {
    setState(() {
      tappedIndex = index;
    });
  }

  void _onTextChanged(String value) {
    setState(() {
      textFieldValue = value;
    });
  }

  final Footer = [
    "About",
    "Press",
    "Contact",
    "Privacy",
    "FAQs"
  ];

  @override
  void initState() {
    super.initState();
    _startOpacityAnimation();
    _loadUsername();
    footer = List<bool>.filled(Footer.length, false);
  }

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = (prefs.getString('username') ?? '');
      print("Data from shared preference");
      print("$name....................");
    });
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

  Future<void> _logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove("username");
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    } catch (e) {
      // Handle error or show a message
      print("Error during logout: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      drawer: s.width > 750 ? null : CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: s.width > 750
            ? Container()
            : Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
        title: RichText(
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
        actions: [
          MouseRegion(
            onHover: (event) {
              setState(() {
                signButton = true;
              });
            },
            onExit: (event) {
              setState(() {
                signButton = false;
              });
            },
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PhoneAuth()));
              },
              child: name.isEmptyOrNull
                  ? Container(
                      height: 35,
                      width: 95,
                      decoration: BoxDecoration(
                        color: signButton ? Colors.white : Color.fromRGBO(12, 194, 255, 1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                          color: signButton ? Colors.white : Color.fromRGBO(12, 194, 255, 1),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: GoogleFonts.poppins(
                            color: signButton ? Color.fromRGBO(12, 194, 255, 1) : Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    )
                  : PopupMenuButton<String>(
                      offset: Offset(0, 40),
                      child: Container(
                        height: double.infinity,
                        child: Center(
                          child: Text(
                            " $name",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            child: ListTile(
                              leading: Icon(Icons.logout),
                              title: Text('Log Out'),
                              onTap: () async {
                                Navigator.pop(context);
                                await _logout();
                              },
                            ),
                          ),
                        ];
                      },
                    ),
            ),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  visible = !visible;
                });
              },
              icon: Icon(
                CupertinoIcons.circle_grid_3x3_fill,
                color: Colors.white,
              )),
          SizedBox(
            width: 20 * s.customWidth,
          )
        ],
      ),
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

          //main page
          Column(
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Search",
                              style: GoogleFonts.poppins(
                                fontSize: s.width > 700 ? 50 : 40 * s.customHeight,
                              )),
                          TextSpan(
                            text: " 70 Millions",
                            style: GoogleFonts.poppins(
                              fontSize: s.width > 700 ? 50 : 40 * s.customHeight,
                              color: const Color.fromRGBO(12, 193, 254, 1),
                            ),
                          ),
                        ]),
                      ),
                      Text("India Customs Sea",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: s.width > 700 ? 50 : 40 * s.customHeight,
                          )),
                      Text("Shipments Records Instantly",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: s.width > 700 ? 50 : 40 * s.customHeight,
                          )),
                      SizedBox(
                        height: 30 * s.customHeight,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(50), right: Radius.circular(50)),
                        ),
                        height: 50,
                        width: s.width / (s.width > 900 ? 2.6 : 1.3),
                        // width: s.width,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                child: TextField(
                                  onChanged: _onTextChanged,
                                  controller: searchController,
                                  cursorColor: Colors.white,
                                  showCursor: true,
                                  decoration: InputDecoration.collapsed(
                                    fillColor: Colors.black,
                                    focusColor: Colors.black,
                                    hintText: 'Enter Company Name',
                                    hintStyle: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                String text = searchController.text;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Result(
                                              search: text,
                                            )));
                              },
                              hoverColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Container(
                                // width: 60,
                                child: CircleAvatar(
                                  // radius: 30,
                                  backgroundColor: Color.fromARGB(255, 27, 181, 253),
                                  child: Icon(
                                    Icons.search,
                                    size: 20.0,
                                    color: Colors.white,
                                  ),
                                ).pSymmetric(v: 8, h: 5),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30 * s.customHeight,
                      ),
                      InkWell(
                        onTap: () {
                          String text = searchController.text;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Result(
                                        search: text,
                                      )));
                        },
                        child: RandomCompanyName(),
                      ),
                      SizedBox(
                        height: 100 * s.customHeight,
                      ),
                    ],
                  ),
                ),
              ),

              //Footer
              Container(
                color: Colors.white30,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: Footer.map((item) {
                    int index = Footer.indexOf(item);
                    return MouseRegion(
                      onHover: (event) {
                        setState(() {
                          footer[index] = true;
                        });
                      },
                      onExit: (event) {
                        setState(() {
                          footer[index] = false;
                        });
                      },
                      child: InkWell(
                        onTap: () {
                          // Handle tap
                          if (footer[0]) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));
                          } else if (footer[1]) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => pressKit()));
                          } else if (footer[2]) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Contact()));
                          } else if (footer[3]) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Policies()));
                          } else if (footer[4]) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));
                          }
                        },
                        child: Container(
                          // color: Colors.green,
                          child: Text(
                            item,
                            style: GoogleFonts.poppins(
                              decoration: footer[index] ? TextDecoration.underline : TextDecoration.none,
                              decorationColor: Color.fromARGB(255, 12, 194, 255),
                              color: footer[index] ? Color.fromARGB(255, 12, 194, 255) : Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ).px(s.width > 700 ? 32 : 12),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
          Visibility(
            visible: visible,
            child: Positioned(
              top: 0,
              right: s.width < 700 ? 0 : 120 * s.customWidth,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                width: 380,
                height: 270,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(7),
                  color: Color(0xffffffff),
                ),
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    InkWell(
                      onTap: () {
                        OnTapMenu(0);
                      },
                      child: Container(
                        height: 110,
                        width: 100,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: tappedIndex == 0 ? Color(0xfff2f6f7) : Colors.transparent),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/1.png"),
                            10.heightBox,
                            Text(textAlign: TextAlign.center, "Power Query")
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        OnTapMenu(1);
                      },
                      child: Container(
                        height: 110,
                        width: 100,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: tappedIndex == 1 ? Color(0xfff2f6f7) : Colors.transparent),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/2.png"),
                            10.heightBox,
                            Text(textAlign: TextAlign.center, "Settings")
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        OnTapMenu(2);
                      },
                      child: Container(
                        height: 110,
                        width: 100,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: tappedIndex == 2 ? Color(0xfff2f6f7) : Colors.transparent),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/3.png"),
                            10.heightBox,
                            Text(textAlign: TextAlign.center, "Smart Bookmarks")
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        OnTapMenu(3);
                      },
                      child: Container(
                        height: 110,
                        width: 100,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: tappedIndex == 3 ? Color(0xfff2f6f7) : Colors.transparent),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/4.png"),
                            10.heightBox,
                            Text(textAlign: TextAlign.center, "H.s Code Explorer")
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        OnTapMenu(4);
                      },
                      child: Container(
                        height: 110,
                        width: 100,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: tappedIndex == 4 ? Color(0xfff2f6f7) : Colors.transparent),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/5.png"),
                            10.heightBox,
                            Text(textAlign: TextAlign.center, "Supplier Search")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RandomCompanyName extends StatefulWidget {
  @override
  _RandomCompanyNameState createState() => _RandomCompanyNameState();
}

class _RandomCompanyNameState extends State<RandomCompanyName> {
  final List<String> buttonNames = [
    'Random Company',
    'Super Company',
    'That Company',
    'Cool Company',
    'Lucky Company'
  ];
  int currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % buttonNames.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 170,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            // Slide transition for the animation

            final offsetAnimation = Tween<Offset>(
              begin: Offset(0, 1),
              end: Offset(0, 0),
            ).animate(animation);

            return ClipRect(
              child: SlideTransition(
                position: offsetAnimation,
                child: child,
              ),
            );
          },
          child: Text(
            buttonNames[currentIndex],
            key: ValueKey<String>(buttonNames[currentIndex]), // Unique key for each text
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
