// QR SCANNER -- BARCODE SCAN PACKAGE

import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:qr_gen_rd/styles/clip_path.dart';
import 'package:qr_gen_rd/styles/navbar.dart';
import 'package:qr_gen_rd/styles/style.dart';
import 'package:qr_gen_rd/Screens/requests/iot_temp.dart';
import 'package:google_fonts/google_fonts.dart';

class ScanScreen extends StatefulWidget{
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen>{
  String barcode = "";  // To store barcode info
  String tempResult =""; // To store temp result

  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: BottomNavBar(navIcon: 4,),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    gradient:LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.lightBlueAccent,
                        Colors.blue,
                      ],
                    ),
                  ),
                  width: double.infinity,
                  height: 280,
                  child: Stack(alignment: Alignment.center, children: <Widget>[
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
              Container(
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
                    child: Center(child: Icon(MdiIcons.qrcodeScan,color: Colors.white,)),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(15),
              child:Card(
                color: Colors.pinkAccent,
                elevation: 3,
                child: Column(
                  children: <Widget>[
                    Text(barcode,textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                    SizedBox(height: 5,),
                    Text(tempResult,textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
                  ],
                ),
              ), //output text....displayed after scan is done
              ),
            ],
          ),
        ),
      )
    );
  }

  Future scan() async{
    try{
      ScanResult result = await BarcodeScanner.scan();
      String temp = await IotServices().getTemp();
      if(result.type == ResultType.Barcode){  //if we got desired scan result instead of error
        setState(()async{
          this.barcode = result.rawContent;
          this.tempResult=  temp;
        }); //sets scanned content to var
      }
    }on PlatformException catch (e){  //Exception raised in try block on Platform interaction basis
      if(e.code == BarcodeScanner.cameraAccessDenied){  //is exception is camera Permission denial
        setState((){
          this.barcode = 'The user did not grant the camera permission!';
        });
      }else{    //unknown exception
        setState(()=> this.barcode = "[Unknown Error]: $e");
      }
    }on FormatException{    //if desired format exception raised
      setState(()=>this.barcode = 'null User Returned Using Back button');
    }catch(e){
      setState(()=>this.barcode = 'Unknown error: $e');
    }
  }
}