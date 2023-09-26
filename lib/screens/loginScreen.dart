import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../loginKey.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  // bool pass = true;
  ValueNotifier pass = ValueNotifier(true);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Login to your account',
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: username,
                      decoration: InputDecoration(
                        labelText: "User Name",
                      ),
                    ),
                    SizedBox(height: 20),
                    ValueListenableBuilder(
                      valueListenable: pass,
                      builder: (BuildContext context, isVisible, child) {
                        return TextFormField(
                          controller: password,
                          obscureText: !isVisible,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () {
                                pass.value = !isVisible;
                              },
                              child: pass.value == true
                                  ? Icon(Icons.remove_red_eye)
                                  : Icon(Icons.visibility_off),
                            ),
                            labelText: "Password",
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (username.text.isEmpty || password.text.isEmpty) {
                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: Text("Fill DATAAA"),
                    ),
                  );
                 
                } else {
                  var sharedPref = await SharedPreferences.getInstance();
                  sharedPref.setBool(KEYLOGIN, true);
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
