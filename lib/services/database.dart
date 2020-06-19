import 'package:cloud_firestore/cloud_firestore.dart';

//FOR USER-- Authentication

// Used to create a user class and hold user data
class User{
  final String uid;
  User({this.uid}); //Document uid
}

// User Data Model
class UserPersonelData{
  String email;
  String name;
  String dob;
  bool previousCoronaPos;
  String healthIssues;

  // Constructor
  UserPersonelData({
    this.email,
    this.name,
    this.dob,
    this.previousCoronaPos,
    this.healthIssues,
  }); 
}

final Firestore _firestore  = Firestore.instance; // Creates a firestore DB instance
final String  _userCollection = 'user_data';  // Collection name in firestore DB

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});  //Document uid

  //Collection Reference:-:reference to collection of a database


  Future updateUserData(UserPersonelData data)async {
    return await _firestore.collection(_userCollection).document(uid).setData({
      'uid' : uid,
      'email': data.email,
      'name' : data.name,
      'DOB'  : data.dob,
      'CoronaHist'  : data.previousCoronaPos,
      'HealthIssue'  : data.healthIssues,
    });
  }
}

// FOR ROUTES--

class RoutesData{
  int busno;
  String destination;
  int fare;
  String source;
  String time;

  // Constructor
  RoutesData({
    this.busno,
    this.destination,
    this.fare,
    this.source,
    this.time,
  });
}

final String  _routesCollection = 'routes';

class RouteDatabase{
  final String uid;
  RouteDatabase({this.uid});  //Document uid

  Future updateUserData(RoutesData data)async {
    return await _firestore.collection(_routesCollection).document(uid).setData({
      'uid' : uid,
      'busno': data.busno,
      'destination' : data.destination,
      'fare'  : data.fare,
      'source'  : data.source,
      'time'  : data.time,
    });
  }
}
