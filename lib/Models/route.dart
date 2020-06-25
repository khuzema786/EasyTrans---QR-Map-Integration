// Routes class to hold uid
import 'package:qr_gen_rd/Models/user.dart';

//class Routes{
//  final User uid;
//  Routes({this.uid}); //Document uid
//}

// Routes Data Model
class RoutesData{
  String uid;
  String source;
  String destination;
  int time;
  int busno;
  int fare;
  int seats;
  String routes;

  // Constructor
  RoutesData({
    this.uid,
    this.source,
    this.destination,
    this.time,
    this.busno,
    this.fare,
    this.seats,
    this.routes,
  });
}
