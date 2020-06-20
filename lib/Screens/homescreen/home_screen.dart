import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_gen_rd/Screens/homescreen/gen.dart';
import 'package:qr_gen_rd/Screens/homescreen/scan.dart';
import 'package:qr_gen_rd/services/auth.dart';
import 'package:qr_gen_rd/services/database.dart';
import 'package:qr_gen_rd/styles/style.dart';

String userDetails = "";
String name = '';

class HomeScreen extends StatelessWidget {
  final AuthService _auth = AuthService();
  final User user;
  HomeScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('QR Code'),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("Logout"),
              onPressed: () async {
                await _auth.signout();
              },
            )
          ],
        ),
        body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      color: pink,
                      textColor: Colors.white,
                      splashColor: Colors.pink,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ScanScreen()));
                      },
                      child: const Text('SCAN QR CODE'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      color: pink,
                      textColor: Colors.white,
                      splashColor: Colors.pink,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GenerateScreen()),
                        );
                      },
                      child: const Text('DISPLAY YOUR QR CODE'),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: StreamBuilder(
                          //This stream is used to fetch dataSnapShots from firestore cloud
                          stream: Firestore.instance
                              .collection('user_data')
                              .snapshots(),
                          builder: (context, snapshot) {
                            List<DocumentSnapshot> dataList = snapshot.data.documents;
                            userDetails = DatabaseService().getUserData(dataList, user);
                            name = userDetails.split('\n')[0].split(':')[1];
                            return Container();
                          }
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('Name: $name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    ),
                    //child:DataList(),
                  ),
                ],
              ),
            )
      )
    );
  }
}
