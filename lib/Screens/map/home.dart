import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:qr_gen_rd/states/app_state.dart'; //AppState Management
import 'package:qr_gen_rd/styles/style.dart'; //Stylesheet
import 'package:qr_gen_rd/Screens/payments/payment.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qr_gen_rd/styles/loading.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AppState(),
        )
      ],
      child: Scaffold(
        body: Map(),
      ),
    );
  }
}

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return appState.initialPosition == null
        ? Container(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Loading(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: appState.locationServiceActive == false,
                // If app is unable to load initial position
                child: TypewriterAnimatedTextKit(
                  text: ["Please enable location services"],
                  textStyle: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              )
            ],
          ))
        : Stack(
            children: <Widget>[
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: appState.initialPosition,
                  // Setting up zoom value
                  zoom: 15,
                ),
                // Method called when the map is ready to be used.
                onMapCreated: appState.onCreated,
                // Enabling current location
                myLocationEnabled: true,
                // Type of map
                mapType: MapType.normal,
                // Displays a compass
                compassEnabled: true,
                // To set markers
                markers: appState.markers,
                // Method called when map is rolledover
                onCameraMove: appState.onCameraMove,
                // Displays polyline on Map
                polylines: appState.polyLines,
              ),
              Positioned(
                // Textfield For Source
                top: 65.0,
                right: 15.0,
                left: 15.0,
                child: Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 3.0),
                          blurRadius: 10,
                          spreadRadius: 3)
                    ],
                  ),
                  child: TextField(
                    cursorColor: Colors.black,
                    controller: appState.locationController,
                    textInputAction: TextInputAction.go,
                    onChanged: (value) {
                      print("SOURCE VALUE SUBMITTED: $value");
                      appState.source(value);
                    },
                    decoration: InputDecoration(
                      icon: Container(
                        margin: EdgeInsets.only(left: 20, bottom: 10),
                        width: 10,
                        height: 10,
                        child: Icon(
                          Icons.location_on,
                          color: Colors.blue,
                        ),
                      ),
                      hintText: "Enter The Source...",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15.0, top: 5.0),
                    ),
                  ),
                ),
              ),
              Positioned(
                // Textfield for destination
                top: 125.0,
                right: 15.0,
                left: 15.0,
                child: Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 3.0),
                          blurRadius: 10,
                          spreadRadius: 3)
                    ],
                  ),
                  child: TextField(
//                    onTap: () async{
//                      await appState.getLocationAutoComplete(context);
//                      //await appState.sendRequest(appState.p.description);
//                    },
                    cursorColor: Colors.black,
                    controller: appState.destinationController,
                    textInputAction: TextInputAction.go,
                    onSubmitted: (value) {
                      print("DESTINATION VALUE SUBMITTED: $value");
                      appState.sendRequest(value);
                    },
                    decoration: InputDecoration(
                      icon: Container(
                        margin: EdgeInsets.only(left: 20, bottom: 9),
                        width: 10,
                        height: 10,
                        child: Icon(
                          Icons.directions_bus,
                          color: Colors.blue,
                        ),
                      ),
                      hintText: "Enter The Destination...",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15.0, top: 5.0),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 18,
                right: 65,
                child: Container(
                  width: 60,
                  height: 60,
                  child: FittedBox(
                    child: FloatingActionButton(
                      hoverElevation: 5,
                      elevation: 3,
                      backgroundColor: Colors.blue.withOpacity(0.9),
                      splashColor: Colors.deepOrange,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Payments()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.payment,color: Colors.white,),
                          Text(
                            "BOOK",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
