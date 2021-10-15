import 'package:adaptive_app_demos/app_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Uses full-screen breakpoints to reflow the widget tree
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    // Reflow from Row to Col when in Portrait mode
    bool useVerticalLayout = screenSize.width < screenSize.height;
    // Hide an optional element if the screen gets too small.
    bool hideDetailPanel = screenSize.shortestSide < 250;
    return Scaffold(
      body: Flex(direction: useVerticalLayout ? Axis.vertical : Axis.horizontal, children: [
        if (hideDetailPanel == false) ...[
          Flexible(child: _LoginDetailPanel()),
        ],
        Flexible(child: _LoginForm()),
      ]),
    );
  }
}

class _LoginDetailPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        color: Colors.grey.shade300,
        child: Text(
          "LOGIN VIEW\nBRANDING",
          style: TextStyle(fontSize: 64),
          textAlign: TextAlign.center,
        ),
      );
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // When login button is pressed, show the Dashboard page.
    void handleLoginPressed() => context.read<AppModel>().login();

    // Example Form, pressing the login button will show the Dashboard page
    return Center(
      // Use a maxWidth so the form is responsive, but does get not too large on bigger screens
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 450),
        // Very small screens may require vertical scrolling of the form
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(decoration: _getTextDecoration("Enter email...")),
                SizedBox(height: 16),
                TextField(decoration: _getTextDecoration("Enter password..."), obscureText: true),
                SizedBox(height: 16),
                OutlinedButton(
                    onPressed: handleLoginPressed,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(16.0),
                      child: Text("Log In"),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

InputDecoration _getTextDecoration(String hint) => InputDecoration(border: OutlineInputBorder(), hintText: hint);
