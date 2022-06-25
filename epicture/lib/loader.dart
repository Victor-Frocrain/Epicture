import 'package:flutter/material.dart';
import 'authenticator.dart';

class _LoadingPage extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    Authenticator.redirect(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: new InkWell(
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            /// Render the Title widget, loader and messages below each other
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      /// Loader Animation Widget
                      CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Colors.blue),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Loading extends StatefulWidget {
  @override
  createState() => _LoadingPage();
}