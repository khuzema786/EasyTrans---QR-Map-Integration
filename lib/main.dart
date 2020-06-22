import 'package:flutter/material.dart';
import 'package:qr_gen_rd/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:qr_gen_rd/services/database.dart';
import 'package:qr_gen_rd/Screens/startUp.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      // It is listening to stream... keeping an eye if the user object changes its state
      value: AuthService()
          .user, //we are accessing user stream from AuthService's instance(line 4 at auth.dart)
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EasyTrans',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,),
        ),
        home: StartUp(),
      ),
    );
  }
}
