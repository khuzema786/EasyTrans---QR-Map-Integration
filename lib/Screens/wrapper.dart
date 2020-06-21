import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_gen_rd/Screens/homescreen/home_screen.dart';
import 'package:qr_gen_rd/Screens/authenticate/authenticate.dart';
import 'package:qr_gen_rd/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*Used to switch betwwen Authentication page and home screen
  condition:- if user is signed in the goto home screen
  implemented using a Provider package.. Provider looks for User obj stream.
  If user obj return non-null value(sign in success) it redirects home-screen */

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context); //accessing user data from the stream
    
    int type;
    if (user != null) {

      StreamBuilder(
      //This stream is used to fetch dataSnapShots from firestore cloud
      stream: Firestore.instance.collection('userType').snapshots(),
      builder: (context, snapshot) {
        List<DocumentSnapshot> dataList = snapshot.data.documents;
        type = DatabaseService().getUserType(dataList,user);
        return Container();
      }
    );
      print('Type: $type');
      if(type == null){type = 0;}
      if(type == 0) {return HomeScreen(user);}
      else{return AdminScreen();}
    } else {
      return Authenticate();
    }
  }
}
