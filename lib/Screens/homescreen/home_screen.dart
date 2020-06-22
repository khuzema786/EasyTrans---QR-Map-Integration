import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_gen_rd/Screens/homescreen/gen.dart';
import 'package:qr_gen_rd/Screens/homescreen/scan.dart';
import 'package:qr_gen_rd/Screens/map/home.dart';
import 'package:qr_gen_rd/services/auth.dart';
import 'package:qr_gen_rd/services/database.dart';
import 'package:qr_gen_rd/styles/clip_path.dart';
import 'package:qr_gen_rd/styles/navbar.dart';
import 'package:qr_gen_rd/styles/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

String userDetails = "";

class HomeScreen extends StatelessWidget {
  final AuthService _auth = AuthService();
  final User user;
  HomeScreen(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(navIcon: 0,),
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/vector.png"),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.lightBlueAccent,
                    Colors.blue,
                  ],
                ),
              ),
              width: double.infinity,
              height: 280,
              child: Stack(alignment: Alignment.centerLeft, children: <Widget>[
                Positioned(
                  top: 10,
                  right: 10,
                  child: FlatButton.icon(
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Logout",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      await _auth.signout();
                    },
                  ),
                ),
                Positioned(
                  left: 23,
                  top: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TypewriterAnimatedTextKit(
                        text: ['WELCOME, Have A Nice Day'],
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                          color: white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
//                      Text(
//                        "Have a nice day",
//                        style: TextStyle(
//                          color: Colors.white,
//                          fontWeight: FontWeight.w600,
//                        ),
//                      ),
                    ],
                  ),
                ),
//              Positioned(
//                left: 15,
//                bottom: 40,
//                child: Row(
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    Text(
//                      "Have a good day.",
//                      style: GoogleFonts.lobster(
//                        textStyle: TextStyle(
//                          color: Colors.white,
//                          fontSize: 30.0,
//                          fontWeight: FontWeight.w400,
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
              ]),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    splashColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.directions_bus,
                          color: white,
                          size: 70,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Bus',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    splashColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.local_taxi,
                          color: white,
                          size: 70,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Cab',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    splashColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.train,
                          color: white,
                          size: 70,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Train',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
//          SizedBox(
//            height: 10,
//          ),
//          Row(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: <Widget>[
//              Expanded(
//                child: RaisedButton(
//                  color: Colors.blue,
//                  textColor: Colors.white,
//                  splashColor: Colors.blue,
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(18.0),
//                  ),
//                  onPressed: () {
//                    Navigator.push(context,
//                        MaterialPageRoute(builder: (context) => MyHomePage()));
//                  },
//                  child: Row(
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Icon(
//                        MdiIcons.routes,
//                        color: white,
//                        size: 30,
//                      ),
//                      SizedBox(
//                        width: 10,
//                        height: 50,
//                      ),
//                      Text(
//                        'Routes & Schedule',
//                        style: TextStyle(
//                            fontSize: 30, fontWeight: FontWeight.w400),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            ],
//          ),
//          SizedBox(
//            height: 10,
//          ),
//          Row(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: <Widget>[
//              Expanded(
//                child: RaisedButton(
//                  color: Colors.blue,
//                  textColor: Colors.white,
//                  splashColor: Colors.blue,
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(18.0),
//                  ),
//                  onPressed: () {
//                    Navigator.push(context,
//                        MaterialPageRoute(builder: (context) => MyHomePage()));
//                  },
//                  child: Row(
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      Icon(
//                        Icons.history,
//                        color: white,
//                        size: 30,
//                      ),
//                      SizedBox(
//                        width: 10,
//                        height: 50,
//                      ),
//                      Text(
//                        'Trip History',
//                        style: TextStyle(
//                            fontSize: 30, fontWeight: FontWeight.w400),
//                      ),
//                      SizedBox(
//                        height: 5,
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            ],
//          ),
//          SizedBox(
//            height: 10,
//          ),
//          Row(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: <Widget>[
//              Expanded(
//                child: RaisedButton(
//                  color: Colors.blue,
//                  textColor: Colors.white,
//                  splashColor: Colors.blue,
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(18.0),
//                  ),
//                  onPressed: () {
//                    Navigator.push(context,
//                        MaterialPageRoute(builder: (context) => MyHomePage()));
//                  },
//                  child: Row(
//                    children: <Widget>[
//                      Icon(
//                        MdiIcons.help,
//                        color: white,
//                        size: 30,
//                      ),
//                      SizedBox(
//                        width: 10,
//                        height: 50,
//                      ),
//                      Text(
//                        'Helpline',
//                        style: TextStyle(
//                            fontSize: 30, fontWeight: FontWeight.w400),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            ],
//          ),
//          SizedBox(
//            height: 10,
//          ),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        FloatingActionButton(
//                          hoverElevation: 5,
//                          elevation: 3,
//                          backgroundColor: Colors.blue,
//                          splashColor: Colors.deepOrange,
//                          onPressed: () {
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(builder: (context) => GenerateScreen()),
//                            );
//                          },
//                          child: Icon(
//                            MdiIcons.qrcode,
//                            color: white,
//                          ),
//                        ),
//                        FloatingActionButton(
//                          hoverElevation: 5,
//                          elevation: 3,
//                          backgroundColor: Colors.blue,
//                          splashColor: Colors.deepOrange,
//                          onPressed: () {
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(builder: (context) => ScanScreen()),
//                            );
//                          },
//                          child: Icon(
//                            MdiIcons.qrcodeScan,
//                            color: white,
//                          ),
//                        ),
//                      ],
//                    ),
//                  Padding(
//                    padding: EdgeInsets.all(10),
//                    child: Text(user.uid),
//                    //child:DataList(),
//                  ),
          Padding(
              padding: EdgeInsets.all(10),
              child: StreamBuilder(
                  //This stream is used to fetch dataSnapShots from firestore cloud
                  stream:
                      Firestore.instance.collection('user_data').snapshots(),
                  builder: (context, snapshot) {
                    List<DocumentSnapshot> dataList = snapshot.data.documents;
                    print("Here We Are!");
                    getUserData(dataList, user);
                    return Container();
                  })),
        ],
      ),
    )));
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
