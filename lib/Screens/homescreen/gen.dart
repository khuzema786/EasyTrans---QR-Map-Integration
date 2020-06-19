/*Genertes QR code on given string
Uses qr_flutter package


All the commented codes didnt not affect anything during runtime and will be removed after proper testing*/

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_gen_rd/Screens/homescreen/home_screen.dart';
import 'package:qr_gen_rd/Screens/map/home.dart';
import 'package:qr_gen_rd/styles/style.dart';

class GenerateScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GenerateScreenState();
}

class GenerateScreenState extends State<GenerateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('QR Code Generator'),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                QrImage(
                  data: userDetails,
                  size: 0.5 *
                      (MediaQuery.of(context).size.height -
                          MediaQuery.of(context).viewInsets.bottom),
                  //MediaQuery is used to learn the size of current screen on which app is being used
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  color: pink,
                  textColor: Colors.white,
                  splashColor: Colors.pink,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  },
                  child: const Text('BUS'),
                ),
              ],
            ),
          ),
        ));
  }
}
