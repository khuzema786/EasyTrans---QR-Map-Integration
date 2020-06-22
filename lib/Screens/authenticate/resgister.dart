import 'package:flutter/material.dart';
import 'package:qr_gen_rd/styles/loading.dart';
import 'package:qr_gen_rd/services/database.dart';
import 'package:qr_gen_rd/services/auth.dart';
import 'package:qr_gen_rd/styles/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_gen_rd/styles/clip_path.dart';

/*Function To Provide New Account Regestration Service to our App via FireBase Authentication Service */

class Register extends StatefulWidget {
  //we create inside the WIDGET not the state a property to accept toggling fucntion
  final Function toggleFunction; //the function we recived as a parameter
  Register(
      {this.toggleFunction}); //Constructor used in making passsed parameter a property of widget!..Sounds rather tricky eh
  //however this function can be used inside state object

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //STATE OBJECT for the widget

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<
      FormState>(); //A global key of FormState..Use it to identify our form
  bool loading = false;

  final UserPersonelData data = UserPersonelData();
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ClipPath(
                    clipper: MyClipper(),
                    child: Stack(
                      children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                        gradient:LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.blue,
                            Colors.lightBlueAccent,
                          ],
                        ),
                      ),
                        width: double.infinity,
                        height: 280,
                        child: Stack(alignment: Alignment.center, children: <Widget>[
                          Positioned(
                            top: 10,
                            right: 10,
                            child: FlatButton.icon(
                                onPressed: () {
                                  widget.toggleFunction();
                                },
                                icon: Icon(
                                  Icons.person,
                                  color: white,
                                ),
                                label: Text(
                                  "Login",
                                  style: TextStyle(color: white),
                                )),
                          ),
                          Text(
                            "Register",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lobster(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 50.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ]),
                      ),],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                    child: Form(
                        key: _formKey, //Associating a UID to Form
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                error,
                                style: TextStyle(color: Colors.red),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                //For email
                                decoration: InputDecoration(
                                    labelText: 'Email',
                                    hintText: 'doe@gmail.com',
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2.0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue, width: 2.0))),
                                validator: (value) => value.isEmpty
                                    ? 'Enter Email'
                                    : null, //if value empty return helper text else return nothing
                                //Validator takes a function and returns result to know if form is valid
                                //our form is valid if there is somethin in there
                                onChanged: (value) {
                                  setState(() {
                                    email = value;
                                    data.email = email;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                //for password
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2.0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue, width: 2.0))),
                                validator: (value) => value.length < 6
                                    ? 'Enter Atleast 6 Charaters'
                                    : null,
                                obscureText: true,
                                onChanged: (value) {
                                  setState(() {
                                    password = value;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                  //for Name
                                  decoration: InputDecoration(
                                      labelText: 'Name',
                                      hintText: 'Name',
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2.0)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 2.0))),
                                  validator: (value) =>
                                      value.isEmpty ? 'Enter your name' : null,
                                  onChanged: (value) {
                                    setState(() {
                                      data.name = value;
                                    });
                                  }),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                  //for DOB
                                  decoration: InputDecoration(
                                      labelText: 'Date-Of-Birth',
                                      hintText: 'dd-mm-yyyy',
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2.0)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 2.0))),
                                  validator: (value) => value.isEmpty
                                      ? 'Enter your date-of-birth(dd-mm-yyyy)'
                                      : null,
                                  onChanged: (value) {
                                    setState(() {
                                      data.dob = value;
                                    });
                                  }),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                  //for corona history
                                  decoration: InputDecoration(
                                      labelText:
                                          'Ever tested positive for corona ?',
                                      hintText: 'Y/N',
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2.0)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 2.0))),
                                  validator: (value) => value.isEmpty
                                      ? 'provide valid answer'
                                      : null,
                                  onChanged: (value) {
                                    setState(() {
                                      (value.toLowerCase() == 'y')
                                          ? data.previousCoronaPos = true
                                          : data.previousCoronaPos = false;
                                    });
                                  }),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                  //for corona history
                                  decoration: InputDecoration(
                                      labelText: 'Any Heath Issue ?',
                                      hintText: 'If none, type null',
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2.0)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 2.0))),
                                  validator: (value) => value.isEmpty
                                      ? 'provide valid answer'
                                      : null,
                                  onChanged: (value) {
                                    setState(() {
                                      data.healthIssues = value.toLowerCase();
                                    });
                                  }),
                              SizedBox(
                                height: 20,
                              ),
                              RaisedButton(
                                  elevation: 2,
                                  hoverElevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                    //This here is where Registeration will happen
                                    if (_formKey.currentState.validate()) {
                                      //condition:- is our form valid?
                                      //this validate() method uses validator properties of form
                                      setState(() => loading = true);
                                      //print(data.email);
                                      dynamic result = await _auth
                                          .registerWithEmailAndPassword(
                                              email, password, data);
                                      if (result == null) {
                                        setState(() {
                                          loading = false;
                                          error = 'Please Supply a Valid email!';
                                        });
                                        //Now understand this... IF there is Sucessful Registeration we have a Stream Setup already
                                        //to send user to HomeScreen
                                      }
                                    }
                                  }),
                            ])),
                  )
                ],
              ),
            ),
          ));
  }
}
