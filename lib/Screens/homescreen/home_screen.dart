import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_gen_rd/Screens/map/home.dart';
import 'package:qr_gen_rd/services/auth.dart';
import 'package:qr_gen_rd/services/database.dart';
import 'package:qr_gen_rd/styles/clip_path.dart';
import 'package:qr_gen_rd/styles/navbar.dart';
import 'package:spring/spring.dart';
import 'package:spring/springs/spring_scale.dart';

String userDetails = "";
class HomeScreen extends StatefulWidget {
  final User user;
  HomeScreen(this.user);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService();

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
            height: 290,
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
                top: 23,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TypewriterAnimatedTextKit(
                      text: ['Welcome, Admin'],
                      repeatForever: true,
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
            ),
            Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            /*  AvatarGlow(
                glowColor: Colors.blue,
                endRadius: 90.0,
                duration: Duration(milliseconds: 2000),
                repeat: true,
                showTwoGlows: true,
                repeatPauseDuration: Duration(milliseconds: 100),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHomePage()));
                  },
                  child: Material(
                    elevation: 8.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      child: Icon(
                        Icons.directions_bus,
                        color: Colors.white,
                        size:30,
                      ),
                      radius: 40.0,
                    ),
                  ),
                ),
              ),  */
              SpringScale(
                   motion: Motion.Mirror,
                   begin: 0.9,
                   end: 1.0,
                   animStatus: (T) => print(T),
                   child: Container(
                     height: 0.3 *
                         (MediaQuery.of(context).size.height -
                             MediaQuery.of(context).viewInsets.bottom),
                     width: 0.3 *
                         (MediaQuery.of(context).size.height -
                             MediaQuery.of(context).viewInsets.bottom),
                     child: FittedBox(
                       child: FloatingActionButton(
                         backgroundColor: Colors.blue,
                         elevation: 3,
                         hoverElevation: 5,
                         onPressed: () {
                           Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (context) => MyHomePage()));
                         },
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: <Widget>[
                             Icon(
                               Icons.directions_bus,
                               color: Colors.white,
                               size:45,
                             ),
                           ],
                         ),
                       ),
                     ),
                   ),
               ),
            /*  SizedBox(height: 10,),
              SpringScale(
                motion: Motion.Mirror,
                begin: 0.8,
                end: 1.0,
                animStatus: (T) => print(T),
                child: Container(
                  height: 0.3 *
                      (MediaQuery.of(context).size.height -
                          MediaQuery.of(context).viewInsets.bottom),
                  width: 0.3 *
                      (MediaQuery.of(context).size.height -
                          MediaQuery.of(context).viewInsets.bottom),
                  child: FittedBox(
                    child: FloatingActionButton(
                      backgroundColor: Colors.blue,
                      elevation: 3,
                      hoverElevation: 5,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.local_taxi,
                            color: Colors.white,
                            size:45,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              SpringScale(
                motion: Motion.Mirror,
                begin: 0.8,
                end: 1.0,
                animStatus: (T) => print(T),
                child: Container(
                  height: 0.3 *
                      (MediaQuery.of(context).size.height -
                          MediaQuery.of(context).viewInsets.bottom),
                  width: 0.3 *
                      (MediaQuery.of(context).size.height -
                          MediaQuery.of(context).viewInsets.bottom),
                  child: FittedBox(
                    child: FloatingActionButton(
                      backgroundColor: Colors.blue,
                      elevation: 3,
                      hoverElevation: 5,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.train,
                            color: Colors.white,
                            size:45,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),  */
          ],
      ),
    ),
        ]))));
  }
}