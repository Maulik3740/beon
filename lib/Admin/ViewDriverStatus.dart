import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_ads_web/Admin/HomeScreen.dart';
import 'package:super_ads_web/Admin/Myapp.dart';
import 'package:super_ads_web/Login/phoneAuth.dart';
import 'package:super_ads_web/constant/Constant.dart';
import 'package:super_ads_web/constant/Screen.dart';

class ViewDriverStatus extends StatefulWidget {
  static const String route = "view-user";
  const ViewDriverStatus({super.key});

  @override
  State<ViewDriverStatus> createState() => _ViewDriverStatusState();
}

class _ViewDriverStatusState extends State<ViewDriverStatus> {
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
  var companyId;
  late String companyType;
  @override
  void initState() {
    // Listen to the stream and update loading state accordingly
    inception();
    super.initState();
  }

  inception() async {
    QuerySnapshot qs = await fb
        .collection("AllLeads")
        .doc("tanvi")
        .collection("EmployeeDetails")
        .get();
    allUserInfo = qs.docs;
    print(allUserInfo);
    print(allUserInfo.length);
  }

  Stream<QuerySnapshot> getUsers() {
    return fb
        .collection("AllLeads")
        .doc("tanvi")
        .collection("EmployeeDetails")
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: white,
      // appBar: MyAppBar(scaf foldKey),
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
            if (s.isDesktop) adminHeader(context: context),
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
                                  "VIEW GENERATED LEADS",
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
                                "Here is the list of all generated leads",
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
                                        width: (2 / 26) *
                                            s.width *
                                            s.tableWidthFactor,
                                        title: "No.",
                                      ),
                                      TableAttributeTitle(
                                        secondaryColor: secondaryColor,
                                        width: (4 / 26) *
                                            s.width *
                                            s.tableWidthFactor,
                                        title: "Lead Name",
                                      ),
                                      TableAttributeTitle(
                                        secondaryColor: secondaryColor,
                                        width: (4 / 26) *
                                            s.width *
                                            s.tableWidthFactor,
                                        title: "Lead Phone Phone",
                                      ),
                                      TableAttributeTitle(
                                        secondaryColor: secondaryColor,
                                        width: (4 / 26) *
                                            s.width *
                                            s.tableWidthFactor,
                                        title: "Transport",
                                      ),
                                      TableAttributeTitle(
                                        secondaryColor: secondaryColor,
                                        width: (4 / 26) *
                                            s.width *
                                            s.tableWidthFactor,
                                        title: "Need Work",
                                      ),
                                      TableAttributeTitle(
                                        secondaryColor: secondaryColor,
                                        width: (4 / 26) *
                                            s.width *
                                            s.tableWidthFactor,
                                        title: "Reached",
                                      ),
                                      TableAttributeTitle(
                                        secondaryColor: secondaryColor,
                                        width: (4 / 26) *
                                            s.width *
                                            s.tableWidthFactor,
                                        title: "Time",
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
                                    TableAttributeTitle(
                                      secondaryColor: secondaryColor,
                                      flex: 2,
                                      title: "No.",
                                    ),
                                    TableAttributeTitle(
                                      secondaryColor: secondaryColor,
                                      flex: 4,
                                      title: "Lead Name",
                                    ),
                                    TableAttributeTitle(
                                      secondaryColor: secondaryColor,
                                      flex: 4,
                                      title: "Lead Phone",
                                    ),
                                    TableAttributeTitle(
                                      secondaryColor: secondaryColor,
                                      flex: 4,
                                      title: "Transport",
                                    ),
                                    TableAttributeTitle(
                                      secondaryColor: secondaryColor,
                                      flex: 4,
                                      title: "Need Work",
                                    ),
                                    TableAttributeTitle(
                                      secondaryColor: secondaryColor,
                                      flex: 4,
                                      title: "Reached",
                                    ),
                                    TableAttributeTitle(
                                      secondaryColor: secondaryColor,
                                      flex: 4,
                                      title: "Time",
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
        String name = ds["Name"],
            phone = ds["PhoneNumber"],
            NeedWork = ds["NeedWork"],
            Transport = ds["Transport"],
            CreatedAt = ds["CreatedAt"],
            userInfo = ds["Contacted"];
        String transport =
            (Transport != null && Transport.isNotEmpty) ? Transport : "N/A";
        String needWork =
            (NeedWork != null && NeedWork.isNotEmpty) ? NeedWork : "N/A";
        String UserInfo =
            (userInfo != null && userInfo.isNotEmpty) ? userInfo : "N/A";

        phoneEdit.text = phone.substring(3);
        _nameController.text = name;

        return Container(
          decoration: BoxDecoration(color: Colors.grey.shade200),
          height: 50,
          child: Row(
            children: [
              TableEntry(
                // flex: 2,
                borderColor: grey50,
                width: (2 / 26) * s.width * s.tableWidthFactor,
                text: "${(index + 1).toString()}.",
              ),
              TableEntry(
                // flex: 8,
                borderColor: grey50,
                width: (4 / 26) * s.width * s.tableWidthFactor,
                child: TextButton(
                  onPressed: () async {},
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (states) => textButtonResolve(states,
                          primary: grey, secondary: black),
                    ),
                  ),
                  child: Text(name),
                ),
              ),
              TableEntry(
                width: (4 / 26) * s.width * s.tableWidthFactor,
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
                  child: Text(phone),
                ),
              ),
              TableEntry(
                width: (4 / 26) * s.width * s.tableWidthFactor,
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
                  child: Text(transport),
                ),
              ),
              TableEntry(
                width: (4 / 26) * s.width * s.tableWidthFactor,
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
                  child: Text(needWork),
                ),
              ),
              TableEntry(
                width: (4 / 26) * s.width * s.tableWidthFactor,
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
                  child: Text(UserInfo),
                ),
              ),
              TableEntry(
                width: (4 / 26) * s.width * s.tableWidthFactor,
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
                  child: Text(CreatedAt),
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
          String name = ds["Name"],
              phone = ds["PhoneNumber"],
              NeedWork = ds["NeedWork"],
              Transport = ds["Transport"],
              CreatedAt = ds["CreatedAt"],
              userInfo = ds["Contacted"];
          String transport =
              (Transport != null && Transport.isNotEmpty) ? Transport : "N/A";
          String needWork =
              (NeedWork != null && NeedWork.isNotEmpty) ? NeedWork : "N/A";
          String UserInfo =
              (userInfo != null && userInfo.isNotEmpty) ? userInfo : "N/A";

          phoneEdit.text = phone.substring(3);
          _nameController.text = name;

          return Container(
            decoration: BoxDecoration(color: Colors.blueGrey.shade50),
            height: 50,
            child: Row(
              children: [
                TableEntry(
                  flex: 2,
                  borderColor: grey50,
                  text: "${index + 1}", // 1-based index
                ),
                TableEntry(
                  flex: 4,
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
                    child: Text(name),
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
                    child: Text(phone),
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
                    child: Text(transport),
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
                    child: Text(needWork),
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
                    child: Text(UserInfo),
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
                    child: Text(CreatedAt),
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
            String name = user["Name"].toString().toLowerCase();
            return name.contains(searchText.toLowerCase());
          }).toList();
        } else if (hintText == "Phone") {
          filteredUser = allUserInfo.where((user) {
            String phone = user["PhoneNumber"].toString().toLowerCase();
            return phone.contains(searchText.toLowerCase());
          }).toList();
        }
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
