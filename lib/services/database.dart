import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

//Used to create a User Class and hold User data
class User{
  final String uid;
  User({this.uid});
}

//A User Data Model
class UserPersonelData{
  String email;
  String name;
  String dob;
  //String haddr;
  bool previousCoronaPos;
  String healthIssues;

  UserPersonelData({    //constructor
    this.email,
    this.name,
    this.dob,
    this.previousCoronaPos,
    this.healthIssues,
  }); 

}

final Firestore _firestore  = Firestore.instance;
final String  _collection = 'user_data';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});  //Document uid

  //Collection Reference:-:reference to collection of a database


  Future updateUserData(UserPersonelData data)async {
    try{
      await  _firestore.collection('userTypes').document(uid).setData({'Type': '0'});
    }catch(e){
      print('error:$e');
    }
    return await _firestore.collection(_collection).document(uid).setData({
      'uid' : uid,
      'email': data.email,
      'name' : data.name,
      'DOB'  : data.dob,
      'CoronaHist'  : data.previousCoronaPos,
      'HealthIssue'  : data.healthIssues,
    });
  }

  String getUserData(List<DocumentSnapshot> dataList, User user) {
    String userDetails;
  /*This Funtion is used to create a string that enables us to generate a qr code*/
  for (var i = 0; i < dataList.length; i++) {
    if (dataList[i].documentID == user.uid) {
      String _name = dataList[i].data['name'];
      String _coronaHist = (dataList[i].data['CoronaHist'] ? 'Yes' : 'No');
      userDetails = "name:$_name\ncorona_history:$_coronaHist";
    }
  }
  return userDetails;
}

  int getUserType(List<DocumentSnapshot> dataList,User admin){
    print('Inside getUserType');
    for(var i=0;i<dataList.length;i++){
      if(dataList[i].documentID == admin.uid){
        print(dataList[i]);
      }
    }
  }
}
