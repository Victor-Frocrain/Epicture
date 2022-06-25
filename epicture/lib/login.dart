import 'package:flutter/material.dart';
import 'package:epicture/authenticator.dart';
import 'authenticator.dart';
import 'loader.dart';

class Login extends StatefulWidget {
  @override
  createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Epicture login"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Container(
              height: 150.0,
              width: 190.0,
              padding: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
              ),
              child: Center(
                child: Image.asset('asset/images/epicture_logo.png'),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 35),
              child: Center(
                child: Text(
                  'EPICTURE',
                  style: TextStyle(color: Colors.indigo, fontSize: 40),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 65),
              child: Center(
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                      onPressed: () async {
                        Authenticator auth = new Authenticator();
                        await auth.authentication();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Loading()),
                              (route) => false,
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Connect with Imgur',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 35),
                              child: Image.asset('asset/images/imgur_logo.png',),
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}