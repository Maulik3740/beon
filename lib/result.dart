import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_ads_web/constant/Screen.dart';
import 'package:super_ads_web/constant/drawer.dart';
import 'package:super_ads_web/constant/navbar.dart';
import 'package:velocity_x/velocity_x.dart';

class Result extends StatefulWidget {
  final String search;

  const Result({super.key, required this.search});
  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  late List<Map<String, dynamic>> Data = [];
  late bool isLoading = true;
  String? selectedDestinationPort; // Initialize with null
  String? selectedTotalShipments; // Initialize with null

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    // Use selected values from dropdowns
    String? destinationPort = selectedDestinationPort;
    String? totalShipments = selectedTotalShipments;

    // Call fetchDataByField with selected values
    fetchDataByField('Exporter Name', widget.search.toUpperCase().toString(), destinationPort, totalShipments);
    print("........$destinationPort, $totalShipments");
  }

  Future<void> fetchDataByField(
    String fieldName,
    String value,
    String? destinationPort,
    String? totalShipments,
  ) async {
    CollectionReference collectionRef = FirebaseFirestore.instance.collection('exports');

    try {
      QuerySnapshot querySnapshot = await collectionRef.limit(20).get();
      List<Map<String, dynamic>> tempData = querySnapshot.docs
          .where((doc) {
            String fieldValue = doc.get(fieldName).toString().toUpperCase();
            bool matchesExporter = fieldValue.contains(value);

            bool matchesDestinationPort = destinationPort == null || doc.get('Country of Destination')?.toString().toUpperCase() == destinationPort.toUpperCase();

            bool matchesTotalShipments = totalShipments == null || int.parse(doc.get('Item No').toString()) >= _shipmentThreshold(totalShipments);

            return matchesExporter && matchesDestinationPort && matchesTotalShipments;
          })
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      setState(() {
        Data = tempData;
        isLoading = false;
      });

      // Optionally, you can print or handle the fetched data here.
      // print('Fetched Data: $Data');
    } on FirebaseException catch (e) {
      if (e.code == 'resource-exhausted') {
        print('Firebase Error: Quota exceeded. Review Firestore usage.');
      } else {
        print('Firebase Error: ${e.message}');
      }
    } catch (e, stackTrace) {
      print('Unexpected error: $e');
      print(stackTrace);
    }
  }

  int _shipmentThreshold(String totalShipments) {
    totalShipments = totalShipments.trim().toUpperCase(); // Ensure trimmed and in uppercase

    switch (totalShipments) {
      case "10+ SHIPMENT":
        return 10;
      case "25+ SHIPMENT":
        return 25;
      case "50+ SHIPMENT":
        return 50;
      case "100+ SHIPMENT":
        return 100;
      case "200+ SHIPMENT":
        return 200;
      case "500+ SHIPMENT":
        return 500;
      default:
        return 0;
    }
  }

  void _clearSelections() {
    setState(() {
      selectedDestinationPort = null;
      selectedTotalShipments = null;
      _fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: s.width > 750 ? null : CustomDrawer(),
      body: Container(
        width: s.width,
        child: Column(
          children: [
            Container(
              height: 60,
              width: s.width > 1024 ? 800 : 500,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  // SizedBox(
                  //   width: 50,
                  // ),
                  Expanded(
                    child: buildCustomDropdownForm(
                        hintText: 'Destination Port',
                        items: [
                          "BELGIUM",
                          "UNITED STATES",
                          "ROMANIA",
                          "SLOVENIA",
                          "GERMANY",
                          "JORDAN",
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            selectedDestinationPort = value.toString();
                            _fetchData();
                          });

                          // print("object...........$value");
                        }),
                  ),
                  // SizedBox(
                  //   width: 50,
                  // ),
                  Expanded(
                    child: buildCustomDropdownForm(
                        hintText: 'Total Shipments',
                        items: [
                          "10+ Shipment",
                          "25+ Shipment",
                          "50+ Shipment",
                          "100+ Shipment",
                          "200+ Shipment",
                          "500+ Shipment",
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            selectedTotalShipments = value.toString();
                            _fetchData();
                          });
                          // print("object...........$value");
                        }),
                  ),
                  s.width < 700
                      ? Container()
                      : InkWell(
                          onTap: () {
                            _clearSelections();
                          },
                          child: Container(
                            width: 100,
                            height: double.infinity,
                            child: Center(
                              child: Text(
                                "Clear",
                                style: GoogleFonts.poppins(color: Colors.blue, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                  s.width > 700
                      ? Container()
                      : InkWell(
                          onTap: () {
                            _clearSelections();
                          },
                          child: Container(
                            width: 40,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        )
                  // SizedBox(
                  //   width: 50,
                  // ),
                ],
              ),
            ),
            isLoading
                ? Container(
                    height: s.height / 1.5,
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.blue,
                    )))
                : Data.isEmpty
                    ? Container(
                        height: s.height / 1.5,
                        child: Center(
                            child: Text(
                          'No data available.',
                          style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        )))
                    : Expanded(
                        child: Container(
                          width: 800,
                          height: double.infinity,
                          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 00.0),
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: Data.length,
                              itemBuilder: (BuildContext context, int index) {
                                Map<String, dynamic> data = Data[index];
                                return Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: s.width > 700 ? 10 : 20, vertical: 10),
                                      decoration: BoxDecoration(
                                        // color: Colors.amber,
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      child: _buildCard(data)),
                                );
                              }),
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> data) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(offset: Offset(0, 3), blurRadius: 7, spreadRadius: 4, color: Colors.grey.shade300),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  data['Exporter Name'] ?? 'Unknown Exporter',
                  style: GoogleFonts.poppins(
                    height: 1.5,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
              ),
              Expanded(
                child: Text(
                  data['Country of Destination'],
                  style: GoogleFonts.montserrat(height: 1.5, fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Text(
            data['Port of Discharge'],
            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.normal),
          ),
          Text(
            data['RITC Code'].toString(),
            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.normal),
          ),
          Text(
            data['Quantity'].toString(),
            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.normal),
          ),
          Text(
            data['Item Desc'],
            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }

  Widget buildCustomDropdownForm({
    required List<String> items,
    required String hintText,
    // required String dropdownValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Theme(
      data: ThemeData(focusColor: Colors.lightBlue),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.transparent,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.transparent,
          )),
          filled: true,
          fillColor: Colors.transparent,
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: MediaQuery.of(context).size.width > 700 ? 15.0 : 0.0),
          // border: OutlineInputBorder(),
        ),
        // value: dropdownValue,
        items: items.map((String item) {
          return DropdownMenuItem(
            value: item,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                item,
                style: GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.white),
              ).pOnly(top: 4),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        iconSize: 30,
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
          // size: 30,
        ).pOnly(top: 2),
        dropdownColor: Colors.black,
      ),
    );
  }
}
