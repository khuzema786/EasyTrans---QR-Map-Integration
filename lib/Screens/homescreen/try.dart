import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:qr_gen_rd/Screens/homescreen/gen.dart';
import 'package:qr_gen_rd/Screens/homescreen/scan.dart';
import 'package:qr_gen_rd/Screens/map/home.dart';
import 'package:qr_gen_rd/services/auth.dart';
import 'package:qr_gen_rd/services/database.dart';
import 'package:qr_gen_rd/styles/style.dart';
import 'package:google_fonts/google_fonts.dart';

String userDetails = "";

class HomeScreen extends StatelessWidget {
  final AuthService _auth = AuthService();
  final User user;
  HomeScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EasyTrans'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.person,
              color: white,
            ),
            label: Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              await _auth.signout();
            },
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Welcome, Have a good day.",
                      style: GoogleFonts.lobster(
                        textStyle: TextStyle(
                          color: Colors.pinkAccent,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: pink,
                          textColor: Colors.white,
                          splashColor: Colors.pink,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ),
                            );
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.directions_bus,
                                color: white,
                                size: 70,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Bus',
                                style: TextStyle(
                                    fontSize: 50, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: pink,
                          textColor: Colors.white,
                          splashColor: Colors.pink,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ),
                            );
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.train,
                                color: white,
                                size: 70,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Train',
                                style: TextStyle(
                                    fontSize: 50, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: pink,
                          textColor: Colors.white,
                          splashColor: Colors.pink,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ),
                            );
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.local_taxi,
                                color: white,
                                size: 70,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Cab',
                                style: TextStyle(
                                    fontSize: 50, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: FloatingActionButton(
                        hoverElevation: 5,
                        elevation: 2,
                        backgroundColor: Colors.pinkAccent,
                        splashColor: Colors.deepOrange,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GenerateScreen()),
                          );
                        },
                        child: Icon(
                          MdiIcons.qrcode,
                          color: white,
                          size: 30,
                        ),
                      ),
                    ),

                    Expanded(
                      child: FloatingActionButton(
                        hoverElevation: 5,
                        elevation: 2,
                        backgroundColor: Colors.pinkAccent,
                        splashColor: Colors.deepOrange,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScanScreen()),
                          );
                        },
                        child: Icon(
                          MdiIcons.qrcodeScan,
                          color: white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(user.uid,style: TextStyle(color: Colors.pinkAccent),),
                  //child:DataList(),
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: StreamBuilder(
                      //This stream is used to fetch dataSnapShots from firestore cloud
                        stream: Firestore.instance
                            .collection('user_data')
                            .snapshots(),
                        builder: (context, snapshot) {
                          List<DocumentSnapshot> dataList =
                              snapshot.data.documents;
                          print("Here We Are!");
                          getUserData(dataList, user);
                          return Container();
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void getUserData(List<DocumentSnapshot> dataList, User user) {
  /*This Funtion is used to create a string that enables us to generate a qr code*/
  for (var i = 0; i < dataList.length; i++) {
    if (dataList[i].documentID == user.uid) {
      String _name = dataList[i].data['name'];
      String _coronaHist = (dataList[i].data['CoronaHist'] ? 'Yes' : 'No');
      userDetails = "name:$_name\ncorona_history:$_coronaHist";
      print(userDetails);
    }
  }

  //return Text(name);
}

