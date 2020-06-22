// QR SCANNER -- BARCODE SCAN PACKAGE

import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:qr_gen_rd/styles/clip_path.dart';
import 'package:qr_gen_rd/styles/navbar.dart';
import 'package:qr_gen_rd/Screens/requests/iot_temp.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spring/spring.dart';
import 'package:spring/springs/spring_scale.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = ""; // To store barcode info
  String tempResult = ""; // To store temp result

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavBar(
          navIcon: 4,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.lightBlueAccent,
                            Colors.blue,
                          ],
                        ),
                      ),
                      width: double.infinity,
                      height: 250,
                      child:
                          Stack(alignment: Alignment.center, children: <Widget>[
                        Text(
                          "Click Me !",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lobster(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 50.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  SpringScale(
                    motion: Motion.Mirror,
                    begin: 0.9,
                    end: 1.0,
                    animStatus: (T) => print(T),
                    child: Container(
                      height: 0.4 *
                          (MediaQuery.of(context).size.height -
                              MediaQuery.of(context).viewInsets.bottom),
                      width: 0.4 *
                          (MediaQuery.of(context).size.height -
                              MediaQuery.of(context).viewInsets.bottom),
                      child: FittedBox(
                        child: FloatingActionButton(
                          hoverElevation: 5,
                          elevation: 3,
                          backgroundColor: Colors.blue,
                          onPressed: () {
                            scan();
                          },
                          child: Center(
                              child: Icon(
                            MdiIcons.qrcodeScan,
                            color: Colors.white,
                          )),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(1.0, 2.0),
                                  blurRadius: 5,
                                  spreadRadius: 0.3)
                            ],
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.blue,
                          ),
                          height: 0.1 *
                              (MediaQuery.of(context).size.height -
                                  MediaQuery.of(context).viewInsets.bottom),
                          width: 0.4 *
                              (MediaQuery.of(context).size.height -
                                  MediaQuery.of(context).viewInsets.bottom),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // SizedBox(height: 5,),
                              // Text(barcode,textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                              Text(
                                tempResult,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
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
          ),
        ));
  }

  Future scan() async {
    try {
      ScanResult result = await BarcodeScanner.scan();
      String temp = await IotServices().getTemp();
      if (result.type == ResultType.Barcode) {
        //if we got desired scan result instead of error
        setState(() async {
          this.barcode = result.rawContent;
          this.tempResult = temp;
        }); //sets scanned content to var
      }
    } on PlatformException catch (e) {
      //Exception raised in try block on Platform interaction basis
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        //is exception is camera Permission denial
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        //unknown exception
        setState(() => this.barcode = "[Unknown Error]: $e");
      }
    } on FormatException {
      //if desired format exception raised
      setState(() => this.barcode = 'null User Returned Using Back button');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
