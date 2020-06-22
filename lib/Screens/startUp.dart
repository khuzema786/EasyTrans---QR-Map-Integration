import 'package:flutter/cupertino.dart';
import 'package:qr_gen_rd/Screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:qr_gen_rd/styles/style.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';

class StartUp extends StatefulWidget {
  @override
  _StartUpState createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> with SingleTickerProviderStateMixin {
  AnimationController controllerBG;
  Animation animationBG;

  @override
  void initState() {
    super.initState();

    // After 2 seconds, go to login screen
    Future.delayed(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Wrapper()),
            ));

    // BG Animation
    controllerBG =
        AnimationController(duration: Duration(seconds: 5), vsync: this);
    animationBG = ColorTween(
            begin: Colors.pink,
            end: Colors.blue) // Tween changes range of animation
        .animate(controllerBG);
    controllerBG.forward();
    controllerBG.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controllerBG.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animationBG.value,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 80,
            width: double.infinity,
            child: Center(
              child: Text(
                'EasyTrans',
                style: GoogleFonts.lobster(
                    textStyle: TextStyle(
                  color: white,
                  fontSize: 50.0,
                  fontWeight: FontWeight.w400,
                )),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          TypewriterAnimatedTextKit(
            text: ['YOUR POCKET TRANSPORT COMPANION'],
            textAlign: TextAlign.center,
            textStyle: TextStyle(
              color: white,
              fontSize: 15.0,
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }
}

//              SvgPicture.asset(
//                  'images/Icon.svg',
//                  height: 10,
//                  width: 10,
//                  color: white,
//                  semanticsLabel: 'Logo'
//              ),

//              Divider(
//                color: white,
//                height: 20,
//                thickness: 5,
//                indent: 60,
//                endIndent: 60,
//              ),
