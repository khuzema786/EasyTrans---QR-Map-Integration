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

var _default =  {
  "Route1":RoutesData(uid:'1001',source:'Kothrud',destination:'Kondhwa',time:0930,busno:1,fare:100,seats:20,routes:'Route1'),

};
//Above is hardcoded routes
//to check from map.... let there be an search input src and dest
//now follwing algorithm suplies us with required fare
/*
  for i=1:length(_default)
  {
    var data = _default["Route"+str(i)];
    if(data.source == src){
      if(data.destination == dest){
        cost = data.fare;
        break;
      }
    }
  }
*/
