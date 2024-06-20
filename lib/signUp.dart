import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_ads_web/constant/toast.dart';
import 'package:super_ads_web/home.dart';

import 'package:velocity_x/velocity_x.dart';

class CreateAccount extends StatefulWidget {
  final String phone;
  // final Function flip;
  const CreateAccount({
    super.key,
    required this.phone,
  });

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController userName = TextEditingController();

  @override
  void dispose() {
    userName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width > 700 ? 500 : MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.grey.shade200)),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
              color: Color(0xfff5fcfe),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                10.heightBox,
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: Image.asset(
                      "assets/mylogo.png",
                      width: 200,
                    ),
                  ),
                ),
                10.heightBox,
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Create an Account",
                    style: GoogleFonts.poppins(
                      color: Color.fromARGB(255, 18, 192, 245),
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                20.heightBox,
                Text(
                  "Name",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                5.heightBox,
                customFormField(
                  name: userName,
                  hintText: "Enter your name",
                ),
                20.heightBox,
                InkWell(
                  onTap: () async {
                    await register(widget.phone, userName.text.toString());
                    // if (!mounted) return;
                    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Home()), (route) => false);
                  },
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Color(0xff34c1ef)),
                    child: Center(
                      child: Text(
                        "Register",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                15.heightBox,
                Row(
                  children: [
                    Text(
                      "Thank you for choosing Beon.",
                      style: GoogleFonts.poppins(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    3.widthBox,
                  ],
                ),
                20.heightBox,
              ],
            ),
          ),
        ],
      ),
    );
  }

  register(String phone, String name) async {
    try {
      await FirebaseFirestore.instance.collection("AllUsers").doc("+91$phone").set({
        'name': name,
        "createdAt": DateTime.now(),
        "phone": "+91$phone",
        "uId": "+91$phone",
      });

      _saveUsername(name);

      buildToast(context, "$name has been registered");

      if (!mounted) return;

      print("$name..........");

      // Delay the navigation slightly to ensure state is consistent
      await Future.delayed(Duration(milliseconds: 100));

      if (!mounted) return;

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      print("Error registering user: $e");
      buildToast(context, "Registration failed: $e");
    }
  }

  void _saveUsername(String _userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _userName);
  }
}

class customFormField extends StatefulWidget {
  final String hintText;
  final bool isPasswordField;
  final TextEditingController name;

  const customFormField({
    Key? key,
    required this.hintText,
    required this.name,
    this.isPasswordField = false,
  }) : super(key: key);

  @override
  _customFormFieldState createState() => _customFormFieldState();
}

class _customFormFieldState extends State<customFormField> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: TextFormField(
        controller: widget.name,
        obscureText: widget.isPasswordField && !_isPasswordVisible,
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 14.5,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  onPressed: _togglePasswordVisibility,
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    size: 18,
                    color: Color(0xff004e66),
                  ),
                )
              : null,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          hintText: widget.hintText,
          hintStyle: GoogleFonts.poppins(
            color: Colors.grey.shade500,
            fontSize: 14.5,
            fontWeight: FontWeight.w400,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide(
              color: Colors.grey.shade500,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide(
              color: Colors.grey.shade500,
            ),
          ),
        ),
      ),
    );
  }
}
