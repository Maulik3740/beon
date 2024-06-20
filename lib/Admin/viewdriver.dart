import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_ads_web/Admin/HomeScreen.dart';
import 'package:super_ads_web/Admin/Myapp.dart';
import 'package:super_ads_web/Login/phoneAuth.dart';
import 'package:super_ads_web/constant/Constant.dart';
import 'package:super_ads_web/constant/Screen.dart';

class ViewDriver extends StatefulWidget {
  static const String route = "view-user";
  const ViewDriver({super.key});

  @override
  State<ViewDriver> createState() => _ViewDriverState();
}

class _ViewDriverState extends State<ViewDriver> {
  FirebaseFirestore fb = FirebaseFirestore.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController phone = TextEditingController(),
      phoneEdit = TextEditingController(),
      _nameController = TextEditingController(),
      email = TextEditingController(),
      name = TextEditingController(),
      company = TextEditingController(),
      address = TextEditingController();
  DateTime dateOfBirth = DateTime.now();
  DateTime currentTime = DateTime.now();
  late DateTime selectedTime;
  final _formKey = GlobalKey<FormState>();

  Color secondaryColor = grey50;
  bool hideAddCompany = false;
  List<String> listOfCompanies = [];
  String selectedCompany = dropdownDummy;
  List<DocumentSnapshot> allUserInfo = [];
  List<DocumentSnapshot> filteredUser = [];
  String hintText = "Name";
  TextEditingController searchController = TextEditingController();

  late String companyType;
  @override
  void initState() {
    inception();
    super.initState();
  }

  inception() async {
    QuerySnapshot qs = await fb.collection("users").get();
    allUserInfo = qs.docs;
    print(allUserInfo.length);
  }

  Stream<QuerySnapshot> getUsers() {
    return fb.collection("users").snapshots();
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

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: white,
      // appBar: MyAppBar(scaffoldKey),
      appBar: s.isDesktop
          ? null
          : AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.black,
              title: Row(
                children: [
                  Text(
                    "SUPER ",
                    style: GoogleFonts.aBeeZee(
                        fontSize: 25, fontWeight: FontWeight.bold, color: red),
                  ),
                  Text(
                    "ADS",
                    style: GoogleFonts.aBeeZee(
                        fontSize: 25, fontWeight: FontWeight.bold, color: red),
                  ),
                ],
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
      body: SizedBox.expand(
        child: Column(
          children: [
            s.isDesktop ? adminHeader(context: context) : SizedBox.shrink(),
            Expanded(
              flex: 60,
              child: ListView(
                physics: const ClampingScrollPhysics(),
                children: [
                  Padding(
                    padding: !s.isDesktop
                        ? const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          )
                        : const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (!s.isDesktop) const SizedBox(height: 10),
                              Container(
                                child: Text(
                                  "ADS USER LIST",
                                  style: GoogleFonts.aBeeZee(
                                    color: dark,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                "Here is a list of all the registered user through ADS App",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              if (!s.isMobile && !s.isTablet)
                                const SizedBox(height: 15),
                            ],
                          ),
                        ),
                        s.isDesktop
                            ? Container(
                                height: 55 * s.customWidth,
                                width: 200 * s.customWidth,
                                child: TextField(
                                  controller: searchController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.1),
                                    hintText: "Search By $hintText",
                                    hintStyle: TextStyle(
                                        color: dark,
                                        fontWeight: FontWeight.bold),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _filterUser(value);
                                    });
                                  },
                                ),
                              )
                            : SizedBox(),
                        s.isDesktop
                            ? Container(
                                height: 52 * s.customWidth,
                                width: 50,
                                child: PopupMenuButton<String>(
                                  icon: Icon(Icons.more_vert_outlined),
                                  onSelected: (value) {
                                    // Handle menu item selection
                                    setState(() {
                                      hintText = value;
                                    });

                                    print('Selected: $value');
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        value: 'Name',
                                        child: Text('Name'),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'Phone',
                                        child: Text('Phone'),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'City',
                                        child: Text('City'),
                                      ),
                                    ];
                                  },
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                  !s.isDesktop
                      ? Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: TextField(
                                  controller: searchController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.1),
                                    hintText: "Search By $hintText",
                                    hintStyle: TextStyle(
                                        color: dark,
                                        fontWeight: FontWeight.bold),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _filterUser(value);
                                    });
                                  },
                                ),
                              ),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: PopupMenuButton<String>(
                                  icon: Icon(Icons.more_vert_outlined),
                                  onSelected: (value) {
                                    // Handle menu item selection
                                    setState(() {
                                      hintText = value;
                                    });

                                    print('Selected: $value');
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        value: 'Name',
                                        child: Text('Name'),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'Phone',
                                        child: Text('Phone'),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'City',
                                        child: Text('City'),
                                      ),
                                    ];
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      : SizedBox(),
                  !s.isDesktop
                      ? Container(
                          constraints: BoxConstraints(
                            maxHeight: s.height * 0.75,
                          ),
                          width: double.infinity,
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.symmetric(
                            horizontal: 10 * s.customWidth,
                            vertical: 10 * s.customWidth,
                          ),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey[200]!,
                              width: 2,
                            ),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: s.width * s.tableWidthFactor,
                                  decoration: BoxDecoration(
                                    color: dark,
                                    border: Border(
                                      bottom: BorderSide(
                                        color: secondaryColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  height: 50,
                                  child: Row(
                                    children: [
                                      TableAttributeTitle(
                                        secondaryColor: secondaryColor,
                                        width: (2 / 35) *
                                            s.width *
                                            s.tableWidthFactor,
                                        title: "No.",
                                      ),
                                      TableAttributeTitle(
                                        secondaryColor: secondaryColor,
                                        width: (4 / 35) *
                                            s.width *
                                            s.tableWidthFactor,
                                        title: "Name",
                                      ),
                                      TableAttributeTitle(
                                        secondaryColor: secondaryColor,
                                        width: (4 / 35) *
                                            s.width *
                                            s.tableWidthFactor,
                                        title: "Phone",
                                      ),
                                      TableAttributeTitle(
                                        secondaryColor: secondaryColor,
                                        width: (5 / 35) *
                                            s.width *
                                            s.tableWidthFactor,
                                        title: "Email",
                                      ),
                                      TableAttributeTitle(
                                        secondaryColor: secondaryColor,
                                        width: (4 / 35) *
                                            s.width *
                                            s.tableWidthFactor,
                                        title: "User Type",
                                      ),
                                      TableAttributeTitle(
                                        secondaryColor: secondaryColor,
                                        width: (4 / 35) *
                                            s.width *
                                            s.tableWidthFactor,
                                        title: "Address",
                                      ),
                                      TableAttributeTitle(
                                        secondaryColor: secondaryColor,
                                        width: (4 / 35) *
                                            s.width *
                                            s.tableWidthFactor,
                                        title: "City",
                                      ),
                                      TableAttributeTitle(
                                        secondaryColor: secondaryColor,
                                        width: (4 / 35) *
                                            s.width *
                                            s.tableWidthFactor,
                                        title: "License Number",
                                      ),
                                      TableAttributeTitle(
                                        secondaryColor: secondaryColor,
                                        width: (4 / 35) *
                                            s.width *
                                            s.tableWidthFactor,
                                        title: "Leads",
                                        showBorder: false,
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: SizedBox(
                                    width: s.width * s.tableWidthFactor,
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: getUsers(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Container(
                                            child: SpinKitWave(
                                              color: grey,
                                              size: 50.0,
                                            ),
                                          );
                                        } else if (searchController
                                            .text.isNotEmpty) {
                                          if (filteredUser.isNotEmpty) {
                                            return userDetailsTileMobile(
                                              s,
                                              s.tableWidthFactor,
                                              filteredUser,
                                            );
                                          } else {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(40.0),
                                              child: Text(
                                                "No User found with this $hintText",
                                                style: TextStyle(
                                                    color: dark,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          }
                                        } else {
                                          List<DocumentSnapshot>
                                              dsListOfCompanies =
                                              (snapshot.data!).docs;
                                          return userDetailsTileMobile(
                                            s,
                                            s.tableWidthFactor,
                                            dsListOfCompanies,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.symmetric(
                            horizontal: 20 * s.customWidth,
                            vertical: 20 * s.customWidth,
                          ),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: secondaryColor,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: dark,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: secondaryColor,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                height: 50,
                                child: Row(
                                  children: [
                                    // TableAttributeTitle(
                                    //   secondaryColor: secondaryColor,
                                    //   flex: 2,
                                    //   title: "No.",
                                    // ),
                                    TableAttributeTitle(
                                      secondaryColor: secondaryColor,
                                      flex: 6,
                                      title: "Name",
                                    ),
                                    TableAttributeTitle(
                                      secondaryColor: secondaryColor,
                                      flex: 4,
                                      title: "Phone",
                                    ),
                                    TableAttributeTitle(
                                      secondaryColor: secondaryColor,
                                      flex: 7,
                                      title: "Email",
                                    ),
                                    TableAttributeTitle(
                                      secondaryColor: secondaryColor,
                                      flex: 4,
                                      title: "User Type",
                                    ),
                                    TableAttributeTitle(
                                      secondaryColor: secondaryColor,
                                      flex: 7,
                                      title: "Address",
                                    ),
                                    TableAttributeTitle(
                                      secondaryColor: secondaryColor,
                                      flex: 4,
                                      title: "City",
                                    ),
                                    TableAttributeTitle(
                                      secondaryColor: secondaryColor,
                                      flex: 5,
                                      title: "License Number",
                                    ),
                                    TableAttributeTitle(
                                      secondaryColor: secondaryColor,
                                      flex: 4,
                                      title: "Leads",
                                      showBorder: false,
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: getUsers(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Container(
                                        child: SpinKitWave(
                                          color: grey,
                                          size: 50.0,
                                        ),
                                      );
                                    } else if (searchController
                                        .text.isNotEmpty) {
                                      if (filteredUser.isNotEmpty) {
                                        return userDetailsTile(
                                          filteredUser,
                                        );
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.all(40.0),
                                          child: Text(
                                            "No User found with this $hintText",
                                            style: TextStyle(
                                                color: dark,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        );
                                      }
                                    } else {
                                      List<DocumentSnapshot> dsListOfCompanies =
                                          (snapshot.data!).docs;
                                      return userDetailsTile(
                                        dsListOfCompanies,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView userDetailsTileMobile(
    Screen s,
    double tableWidthFactor,
    List<DocumentSnapshot> dsListOfCompanies,
  ) {
    return ListView.builder(
      itemCount: dsListOfCompanies.length,
      shrinkWrap: true,
      primary: true,
      scrollDirection: Axis.vertical,
      physics: const ScrollPhysics(),
      itemExtent: 50,
      itemBuilder: (context, index) {
        DocumentSnapshot ds = dsListOfCompanies[index];
        String name = ds["name"],
            phone = ds["phone"],
            Email = ds["email"],
            address = ds["address"],
            city = ds["city"],
            licence = ds["license number"],
            userInfo = ds["userInfo"];
        String displayedName = (name != null && name.isNotEmpty) ? name : "N/A";
        String displayLicence =
            (licence != null && licence.isNotEmpty) ? licence : "N/A";
        String displayCity = (city != null && city.isNotEmpty) ? city : "N/A";
        String displayEmail =
            (Email != null && Email.isNotEmpty) ? Email : "N/A";

        return Container(
          decoration: BoxDecoration(color: Colors.grey.shade200),
          height: 50,
          child: Row(
            children: [
              TableEntry(
                // flex: 2,
                borderColor: grey50,
                width: (2 / 35) * s.width * s.tableWidthFactor,
                text: "${(index + 1).toString()}.",
              ),
              TableEntry(
                // flex: 8,
                borderColor: grey50,
                width: (4 / 35) * s.width * s.tableWidthFactor,
                child: TextButton(
                  onPressed: () async {},
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (states) => textButtonResolve(states,
                          primary: grey, secondary: black),
                    ),
                  ),
                  child: Text(displayedName),
                ),
              ),
              TableEntry(
                width: (4 / 35) * s.width * s.tableWidthFactor,
                borderColor: grey50,
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (states) => textButtonResolve(
                        states,
                        primary: grey,
                        secondary: black,
                      ),
                    ),
                  ),
                  onPressed: () async {},
                  child: Text("+91${phone}"),
                ),
              ),
              TableEntry(
                borderColor: grey50,
                width: (5 / 35) * s.width * s.tableWidthFactor,
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (states) => textButtonResolve(states,
                          primary: grey, secondary: black),
                    ),
                  ),
                  onPressed: () async {},
                  child: Text(
                    displayEmail,
                  ),
                ),
              ),
              TableEntry(
                width: (4 / 35) * s.width * s.tableWidthFactor,
                borderColor: grey50,
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (states) => textButtonResolve(
                        states,
                        primary: grey,
                        secondary: black,
                      ),
                    ),
                  ),
                  onPressed: () async {},
                  child: Text(userInfo),
                ),
              ),
              TableEntry(
                width: (4 / 35) * s.width * s.tableWidthFactor,
                borderColor: grey50,
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (states) => textButtonResolve(
                        states,
                        primary: grey,
                        secondary: black,
                      ),
                    ),
                  ),
                  onPressed: () async {},
                  child: Text(address),
                ),
              ),
              TableEntry(
                width: (4 / 35) * s.width * s.tableWidthFactor,
                borderColor: grey50,
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (states) => textButtonResolve(
                        states,
                        primary: grey,
                        secondary: black,
                      ),
                    ),
                  ),
                  onPressed: () async {},
                  child: Text(displayCity),
                ),
              ),
              TableEntry(
                width: (4 / 35) * s.width * s.tableWidthFactor,
                borderColor: grey50,
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (states) => textButtonResolve(
                        states,
                        primary: grey,
                        secondary: black,
                      ),
                    ),
                  ),
                  onPressed: () async {},
                  child: Text(displayLicence),
                ),
              ),
              TableEntry(
                width: (4 / 35) * s.width * s.tableWidthFactor,
                borderColor: grey50,
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (states) => textButtonResolve(
                        states,
                        primary: grey,
                        secondary: red,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    _showNestedDialog(context, name, phone);
                  },
                  child: Text(
                    "Modify",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ListView userDetailsTile(List<DocumentSnapshot<Object?>> dsListOfCompanies) {
    return ListView.builder(
        itemCount: dsListOfCompanies.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        itemExtent: 50,
        itemBuilder: (context, index) {
          DocumentSnapshot ds = dsListOfCompanies[index];
          String name = ds["name"],
              phone = ds["phone"],
              Email = ds["email"],
              address = ds["address"],
              city = ds["city"],
              licence = ds["license number"],
              userInfo = ds["userInfo"];
          String displayedName =
              (name != null && name.isNotEmpty) ? name : "N/A";
          String displayLicence =
              (licence != null && licence.isNotEmpty) ? licence : "N/A";
          String displayCity = (city != null && city.isNotEmpty) ? city : "N/A";
          String displayEmail =
              (Email != null && Email.isNotEmpty) ? Email : "N/A";

          phoneEdit.text = phone.substring(3);
          _nameController.text = name;

          return Container(
            decoration: BoxDecoration(color: Colors.blueGrey.shade50),
            height: 50,
            child: Row(
              children: [
                // TableEntry(
                //   flex: 2,
                //   borderColor: grey50,
                //   text: "${(index + 1).toString()}.",
                // ),
                TableEntry(
                  flex: 6,
                  borderColor: grey50,
                  child: TextButton(
                    onPressed: () async {},
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.resolveWith(
                        (states) => textButtonResolve(
                          states,
                          primary: grey,
                          secondary: black,
                        ),
                      ),
                    ),
                    child: Text("${displayedName}"),
                  ),
                ),
                TableEntry(
                  flex: 4,
                  borderColor: grey50,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.resolveWith(
                        (states) => textButtonResolve(
                          states,
                          primary: grey,
                          secondary: black,
                        ),
                      ),
                    ),
                    onPressed: () async {},
                    child: Text("+91${phone}"),
                  ),
                ),
                TableEntry(
                  flex: 7,
                  borderColor: grey50,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.resolveWith(
                        (states) => textButtonResolve(
                          states,
                          primary: grey,
                          secondary: black,
                        ),
                      ),
                    ),
                    onPressed: () async {},
                    child: Text("${displayEmail}"),
                  ),
                ),
                TableEntry(
                  flex: 4,
                  borderColor: grey50,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.resolveWith(
                        (states) => textButtonResolve(
                          states,
                          primary: grey,
                          secondary: black,
                        ),
                      ),
                    ),
                    onPressed: () async {},
                    child: Text(
                      userInfo,
                    ),
                  ),
                ),
                TableEntry(
                  flex: 7,
                  borderColor: grey50,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.resolveWith(
                        (states) => textButtonResolve(
                          states,
                          primary: grey,
                          secondary: black,
                        ),
                      ),
                    ),
                    onPressed: () async {},
                    child: Text(
                      address,
                    ),
                  ),
                ),
                TableEntry(
                  flex: 4,
                  borderColor: grey50,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.resolveWith(
                        (states) => textButtonResolve(
                          states,
                          primary: grey,
                          secondary: black,
                        ),
                      ),
                    ),
                    onPressed: () async {},
                    child: Text(
                      "${displayCity}",
                    ),
                  ),
                ),
                TableEntry(
                  flex: 5,
                  borderColor: grey50,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.resolveWith(
                        (states) => textButtonResolve(
                          states,
                          primary: grey,
                          secondary: black,
                        ),
                      ),
                    ),
                    onPressed: () async {},
                    child: Text("${displayLicence}"),
                  ),
                ),
                TableEntry(
                  flex: 4,
                  borderColor: grey50,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.resolveWith(
                        (states) => textButtonResolve(
                          states,
                          primary: black,
                          secondary: red,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      _showNestedDialog(context, name, phone);
                    },
                    child: Text(
                      "Modify",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _filterUser(String searchText) {
    if (searchText.isEmpty) {
    } else {
      setState(() {
        if (hintText == "Name") {
          filteredUser = allUserInfo.where((user) {
            String name = user["name"].toString().toLowerCase();
            return name.contains(searchText.toLowerCase());
          }).toList();
        } else if (hintText == "Phone") {
          filteredUser = allUserInfo.where((user) {
            String phone = user["phone"].toString().toLowerCase();
            return phone.contains(searchText.toLowerCase());
          }).toList();
        } else if (hintText == "City") {
          filteredUser = allUserInfo.where((user) {
            String phone = user["city"].toString().toLowerCase();
            return phone.contains(searchText.toLowerCase());
          }).toList();
        }
      });
    }
  }

  TextEditingController textFieldController = TextEditingController();
  TextEditingController textFieldController2 = TextEditingController();
  TextEditingController textFieldController3 = TextEditingController();
  String selectedValue = '';
  Future<void> saveDataToFirebase(String Name, String Phone) async {
    // Get the values from the controllers
    String value1 = textFieldController.text;
    String value2 = textFieldController2.text;
    String value3 = textFieldController3.text;

    // Access the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference<Map<String, dynamic>> collectionReference2 =
        firestore.collection('AllLeads').doc("tanvi");
    // Reference to the collection in Firestore (replace 'your_collection' with your actual collection name)
    DocumentReference<Map<String, dynamic>> collectionReference = firestore
        .collection('AllLeads')
        .doc("tanvi")
        .collection("EmployeeDetails")
        .doc("${Name}");

    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(now);
      String formattedTime = DateFormat('HH:mm:ss').format(now);
      // Add a new document with a generated ID
      await collectionReference2
          .set({'CreatedAt': FieldValue.serverTimestamp(), 'id': Phone});
      await collectionReference.set({
        'Contacted': value1,
        'Transport': value2,
        'NeedWork': value3,
        'Name': Name,
        'PhoneNumber': "+91${Phone}",
        'CreatedAt': "${formattedDate},$formattedTime",
      });
      buildToast(context, "Data Saved");
      // Data saved successfully
      print('Data saved to Firebase!');
    } catch (e) {
      // Handle errors
      print('Error saving data to Firebase: $e');
    }
  }

  Future<void> _showNestedDialog(
      BuildContext context, String name, String phone) async {
    String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Modify status of Drivers",
            style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),
          ),
          content: Container(
            width: 600,
            height: 470,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 20, top: 50),
                  child: Text(
                    "Have you reached user?",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    onTap: () {
                      _showYesNoDropdown(context);
                    },
                    readOnly: true,
                    style: TextStyle(
                        color: Colors.black, fontSize: 16), // Change text style
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent, // Change background color
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius:
                            BorderRadius.circular(10), // Change border radius
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: Icon(
                        MdiIcons.chevronDown,
                        color: Colors.black,
                      ),
                      labelText: 'Select Option',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: 'Select an option',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    controller: textFieldController,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 20),
                  child: Text(
                    "Transporter Name",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          value.length < 3) {
                        return 'Enter Details';
                      }
                      return null;
                    },
                    style: TextStyle(
                        color: Colors.black, fontSize: 16), // Change text style
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent, // Change background color
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius:
                            BorderRadius.circular(10), // Change border radius
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: Icon(
                        MdiIcons.landFields,
                        color: Colors.grey,
                      ),
                      hintText: 'Enter Details',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    controller: textFieldController2,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 20),
                  child: Text(
                    "Driver needs job?",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    onTap: () {
                      _showYesNoDropdown2(context);
                    },
                    readOnly: true,
                    style: TextStyle(
                        color: Colors.black, fontSize: 16), // Change text style
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent, // Change background color
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius:
                            BorderRadius.circular(10), // Change border radius
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: Icon(
                        MdiIcons.chevronDown,
                        color: Colors.black,
                      ),
                      labelText: 'Select Option',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: 'Select an option',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    controller: textFieldController3,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: dark),
                  onPressed: () {
                    if (textFieldController.text.isNotEmpty &&
                        textFieldController2.text.isNotEmpty &&
                        textFieldController3.text.isNotEmpty) {
                      Navigator.pop(context);
                      saveDataToFirebase(name, phone);
                      setState(() {
                        selectedValue = '';
                        textFieldController.clear();
                        textFieldController2.clear();
                        textFieldController3.clear();
                      });
                    } else {
                      buildToast(context, "Enter All Value!");
                    }
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showYesNoDropdown(BuildContext context) async {
    String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Have you reached user?",
              style: TextStyle(
                  color: black, fontWeight: FontWeight.w600, fontSize: 16)),
          content: Container(
            height: 80,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: dark),
                      onPressed: () {
                        Navigator.pop(context, 'Yes');
                      },
                      child: Text(
                        "Yes",
                        style: TextStyle(
                            color: white, fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, 'No');
                      },
                      child: Text(
                        "No",
                        style: TextStyle(color: black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    // Handle the result (if needed)
    if (result != null) {
      setState(() {
        selectedValue = result;
        textFieldController.text = result;
      });
    }
  }

  Future<void> _showYesNoDropdown2(BuildContext context) async {
    String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Driver want to work",
              style: TextStyle(
                  color: black, fontWeight: FontWeight.w600, fontSize: 16)),
          content: Container(
            height: 80,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: dark),
                      onPressed: () {
                        Navigator.pop(context, 'Yes');
                      },
                      child: Text("Yes",
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.w800)),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, 'No');
                      },
                      child: Text(
                        "No",
                        style: TextStyle(color: black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    // Handle the result (if needed)
    if (result != null) {
      setState(() {
        selectedValue = result;
        textFieldController3.text = result;
      });
    }
  }
}

dynamic textButtonResolve(
  Set<MaterialState> states, {
  required var primary,
  required var secondary,
}) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.dragged,
    MaterialState.focused,
    MaterialState.hovered,
    MaterialState.pressed,
  };
  if (states.any(interactiveStates.contains)) {
    return secondary;
  }
  return primary;
}

class TableAttributeTitle extends StatelessWidget {
  const TableAttributeTitle({
    Key? key,
    this.width,
    required Color? secondaryColor,
    this.flex,
    required this.title,
    this.showBorder,
  })  : _secondaryColor = secondaryColor,
        super(key: key);

  final Color? _secondaryColor;
  final String title;
  final int? flex;
  final double? width;
  final bool? showBorder;

  @override
  Widget build(BuildContext context) {
    return width == null
        ? Expanded(
            flex: flex!,
            child: Container(
              // color: red,
              decoration: BoxDecoration(
                border: showBorder == null || showBorder == true
                    ? Border(
                        right: BorderSide(
                          color: _secondaryColor!,
                          width: 2,
                        ),
                      )
                    : Border.all(
                        color: trans,
                        width: double.minPositive,
                      ),
              ),
              alignment: Alignment.center,
              child: Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16),
              ),
            ),
          )
        : Container(
            // color: red,
            width: width,
            decoration: BoxDecoration(
              border: showBorder == null || showBorder == true
                  ? Border(
                      right: BorderSide(
                        color: _secondaryColor!,
                        width: 2,
                      ),
                    )
                  : Border.all(
                      color: trans,
                      width: double.minPositive,
                    ),
            ),
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16),
            ),
          );
  }
}

class TableEntry extends StatelessWidget {
  final int? flex;
  final String? text;
  final Alignment? alignment;
  final bool? showBorder, isHoveringText;
  final double? width;
  final Widget? child;
  final Color? borderColor;
  const TableEntry({
    Key? key,
    this.child,
    this.flex,
    this.isHoveringText,
    this.alignment,
    this.text,
    this.width,
    this.borderColor,
    this.showBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return width == null
        ? Expanded(
            flex: flex!,
            child: Container(
              decoration: BoxDecoration(
                border: (showBorder ?? true)
                    ? Border(
                        right: BorderSide(
                          color: borderColor ?? Colors.grey[400]!,
                          width: 2,
                        ),
                      )
                    : Border.all(color: trans, width: double.minPositive),
              ),
              alignment: alignment ?? Alignment.center,
              child: child ?? Text(text!),
            ),
          )
        : Container(
            width: width,
            decoration: BoxDecoration(
              border: (showBorder ?? true)
                  ? Border(
                      right: BorderSide(
                        color: borderColor ?? Colors.grey[400]!,
                        width: 2,
                      ),
                    )
                  : Border.all(color: trans, width: double.minPositive),
            ),
            alignment: alignment ?? Alignment.center,
            child: child ?? Text(text!),
          );
  }
}

TextStyle viewDetailsTitleTextStyle({Color? color}) {
  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: color ?? Colors.grey[600],
  );
}

TextStyle viewDetailsValueTextStyle({Color? color}) {
  return TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: color ?? grey,
  );
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
                  builder: (context) => PhoneAuth(),
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
