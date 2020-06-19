// QR SCANNER -- BARCODE SCAN PACKAGE

import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_gen_rd/styles/style.dart';
import 'package:qr_gen_rd/Screens/requests/iot_temp.dart';

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
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,     // Center vertically
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretched horizontally
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(17),
              child:RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: pink,
                textColor: Colors.white,
                splashColor: Colors.deepOrange,
                onPressed:scan,
                child: const Text('START SCAN'),
              ),
            ),
            Padding(padding: EdgeInsets.all(15),
            child:Column(
              children: <Widget>[
                Text(barcode,textAlign: TextAlign.center,),
                Text(tempResult,textAlign: TextAlign.center,),
              ],
            ), //output text....displayed after scan is done
            ),
          ],
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