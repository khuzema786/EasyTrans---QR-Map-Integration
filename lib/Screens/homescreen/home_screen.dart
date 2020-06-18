import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_gen_rd/Screens/homescreen/gen.dart';
import 'package:qr_gen_rd/Screens/homescreen/scan.dart';
import 'package:qr_gen_rd/services/auth.dart';
import 'package:qr_gen_rd/services/database.dart';
import 'package:qr_gen_rd/styles/style.dart';

String userDetails = "";

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
                    child: Text(user.uid),
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

/*Stream<DocumentSnapshot> provideDocumentFieldStream(User user) {
    return Firestore.instance.collection('user_data').document(user.uid).snapshots();
  }
Widget getUserDataFromDatabase(User user){
  StreamBuilder<DocumentSnapshot>(
    stream: provideDocumentFieldStream(user),
    builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
      if(snapshot.hasData){
        //snapshot -> AsyncSnapshot of DocumentSnapshot
        //snapshot.data -> DocumentSnapshot
        //snapshot.data.data -> Map of fields that you need :)

        Map<String,dynamic> documentFields = snapshot.data.documents[user.uid];
        //TODO Okay, now you can use documentFields (json) as needed
        print(documentFields['name']);

        return (Text(documentFields['name']));
      }
    }
  );
}*/
