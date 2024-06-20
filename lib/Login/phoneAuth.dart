import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_ads_web/Admin/Myapp.dart';
import 'package:super_ads_web/constant/Constant.dart';
import 'package:super_ads_web/home.dart';
import 'package:super_ads_web/signUp.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({Key? key}) : super(key: key);

  @override
  State<PhoneAuth> createState() => _InceptionState();
}

class _InceptionState extends State<PhoneAuth> {
  bool isOtpSent = false, isLoading = false;
  String? phone, otp, verificationId, uID;
  late ConfirmationResult confirmationResult;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  Future<bool> checkIfUserExists(String phone) async {
    try {
      print("Checking for user existence with phone: $phone");

      var result = await FirebaseFirestore.instance.collection('AllUsers').doc(phone).get();
      if (result.exists) {
        String name = result['name'];

        void _saveUsername() async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('username', name);
        }

        _saveUsername();

        print("User with phone $phone exists.");
      } else {
        print("User with phone $phone does not exist.");
      }

      return result.exists;
    } catch (error) {
      print('Error checking user existence: $error');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    double customWidth = width / macbookWidth;
    double customHeight = height / macbookHeight;
    bool isMobile = customWidth <= 0.4;
    bool isTablet = !isMobile && width < 1000;
    customWidth = 1;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, opacity: 0.3, image: AssetImage('assets/lottie/bbb.webp'))),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Container(
            width: width * ((isMobile || isTablet) ? 0.9 : 0.6),
            height: isMobile ? null : height * 0.75,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7.5),
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 30, (isMobile || isTablet) ? 30 : 0, 30),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "BEON",
                            style: GoogleFonts.aBeeZee(
                              color: blue,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.5,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            "Sign In",
                            style: GoogleFonts.aBeeZee(
                              color: theme,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.5,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(height: 30 * customWidth),
                          const Text(
                            "Login with your phone number and an OTP.",
                            style: TextStyle(
                              color: grey,
                              fontSize: 16,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(
                            height: 30 * customWidth,
                          ),
                          TextField(
                            controller: _phoneController,
                            cursorHeight: 20,
                            decoration: InputDecoration(
                              prefixIcon: TextButton(
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(trans),
                                  visualDensity: VisualDensity.compact,
                                ),
                                onPressed: () {},
                                child: const Text(
                                  "+91",
                                  style: TextStyle(
                                    color: grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                              suffixIcon: TextButton(
                                onPressed: () {
                                  if (validatePhone(phone!)) {
                                    sendPhoneOTP(context);
                                    isOtpSent = true;
                                    print("otp sent");
                                  } else {
                                    buildToast(
                                      context,
                                      "Invalid phone number",
                                    );
                                  }
                                },
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                      horizontal: 20 * customWidth,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Send OTP",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14 * customWidth,
                                    color: black,
                                  ),
                                ),
                              ),
                              labelText: width < 400 ? "  Phone  " : "  Phone Number  ",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10 * customWidth,
                                ),
                                borderSide: const BorderSide(
                                  color: theme,
                                  width: 2,
                                ),
                              ),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              if (!isOtpSent) phone = value;
                            },
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: 30 * customWidth,
                          ),
                          TextField(
                            controller: _otpController,
                            enabled: isOtpSent,
                            decoration: InputDecoration(
                              labelText: "  OTP  ",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10 * customWidth,
                                ),
                                borderSide: const BorderSide(
                                  color: theme,
                                  width: 2,
                                ),
                              ),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(6),
                            ],
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              otp = value;
                            },
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(
                            height: 30 * customWidth,
                          ),
                          TextButton(
                            onPressed: () {
                              verifyPhoneOTP(context);

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (builder) => const Home(),
                              //   ),
                              // );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(theme),
                              padding: MaterialStateProperty.all(
                                isMobile
                                    ? const EdgeInsets.symmetric(
                                        horizontal: 23.5,
                                        vertical: 13,
                                      )
                                    : const EdgeInsets.symmetric(
                                        horizontal: 35,
                                        vertical: 20,
                                      ),
                              ),
                            ),
                            child: Text(
                              "Submit OTP",
                              style: GoogleFonts.aBeeZee(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30 * customWidth,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (!isMobile && !isTablet)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(40),

                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Lottie.asset(
                        'assets/lottie/animation.json',
                      ),
                      // child: Image.asset("assets/images/doctor2.png"),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validatePhone(String value) {
    Pattern pattern = r'''^[6-9][0-9]{9}$''';
    RegExp regExp = RegExp(pattern as String);
    if (value.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    } else if (value.length < 5) {
      return false;
    }
    return true;
  }

  sendPhoneOTP(BuildContext context) async {
    print("enter");
    String p = "+91${phone!}";
    print(p);
    if (kIsWeb) {
      print("it is web");

      buildToast(context, "Sending OTP");
      confirmationResult = await firebaseAuth.signInWithPhoneNumber(p);
      print("ggg${confirmationResult}");
      if (mounted) {
        buildToast(context, "OTP sent!");
        print("ggg}");
      }
      setState(() {
        isOtpSent = true;
      });
    }
  }

  void verifyPhoneOTP(BuildContext context) async {
    String uID = "+91$phone";
    print(phone);
    setState(() {
      isLoading = true;
    });

    if (kIsWeb) {
      try {
        // Confirm the OTP using the confirmationResult
        await confirmationResult.confirm(otp!);

        // If the confirmation is successful, proceed with additional steps
        buildToast(context, "OTP verified.");

        var sharePref = await SharedPreferences.getInstance();
        sharePref.setBool(MyAppState.KEYLOGIN, true);

        bool isRegistered = await checkIfUserExists(uID);

        if (isRegistered) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CreateAccount(
                phone: phone.toString(),
              ),
            ),
          );
        }
      } catch (e) {
        print("Error during verification: $e");
        buildToast(context, "Wrong OTP. Please enter the correct OTP.");
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  void buildToast(BuildContext context, String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
