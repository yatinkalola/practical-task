import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practial_task/homepage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // final form = formKey.currentState!;

  TextEditingController emailEnter = TextEditingController();
  TextEditingController passEnter = TextEditingController();

  final String _email = "yatinkalola@gmail.com";
  final String _pass = "123456";

  // String validEmail(){
  //   if (formKey.currentState!.validate()){
  //     return(Value)

  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: emailEnter,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Enter Email"),
                  validator:
                      //  (value) {
                      //   if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(_email
                      //   {
                      //     return 'Please a valid Email';
                      //   }

                      //   if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      //       .hasMatch(_email)) {
                      //     return 'Please a valid Email';
                      //   }
                      // },
                      // // // onSaved: (value){
                      // // //   _email = value;
                      // // // },

                      (value) =>
                          value != null && !EmailValidator.validate(value)
                              ? 'Enter a valid email'
                              : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: passEnter,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter Password"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password cannot be empty";
                    } else if (value.length < 6) {
                      return "Password length should be atleast 6";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      if (emailEnter.text != _email &&
                          passEnter.text != _pass) {
                        showCupertinoDialog(
                            context: context, builder: createDialogBoth);
                      } else if (emailEnter.text != _email) {
                        showCupertinoDialog(
                            context: context, builder: createDialogEmail);
                      } else if (passEnter.text != _pass) {
                        showCupertinoDialog(
                            context: context, builder: createDialogPassword);
                      } else {
                        showCupertinoDialog(
                            context: context, builder: createDialogSuccess);
                        await Future.delayed(Duration(seconds: 1));
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('_email', emailEnter.text);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      }
                    }
                    // else {
                    //   Navigator.of(context).push(
                    //       MaterialPageRoute(builder: (context) => HomePage()));
                    // }
                  },
                  child: Text("Login"))
            ],
          ),
        ),
      ),
    );
  }

  Widget createDialogEmail(BuildContext context) => CupertinoAlertDialog(
        title: Text(
          "Login Failed",
          style: TextStyle(fontSize: 22),
        ),
        content: Text(
          "Incorrect EmailAddress",
          style: TextStyle(fontSize: 22),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text("Ok"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
  Widget createDialogPassword(BuildContext context) => CupertinoAlertDialog(
        title: Text(
          "Login Failed",
          style: TextStyle(fontSize: 22),
        ),
        content: Text(
          "Incorrect Password",
          style: TextStyle(fontSize: 22),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text("Ok"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
  Widget createDialogSuccess(BuildContext context) => CupertinoAlertDialog(
        title: Text(
          "Login Success",
          style: TextStyle(fontSize: 22),
        ),
        content: Text(
          "Welcome",
          style: TextStyle(fontSize: 22),
        ),
        // actions: [
        //   CupertinoDialogAction(
        //     child: Text("Ok"),
        //     onPressed: () async {
        //       SharedPreferences prefs = await SharedPreferences.getInstance();
        //       prefs.setString('_email', emailEnter.text);
        //       Navigator.of(context)
        //           .push(MaterialPageRoute(builder: (context) => HomePage()));
        //     },
        //   )
        // ],
      );
  Widget createDialogBoth(BuildContext context) => CupertinoAlertDialog(
        title: Text(
          "Login Failed",
          style: TextStyle(fontSize: 22),
        ),
        content: Text(
          "Incorrect Email & Password",
          style: TextStyle(fontSize: 22),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text("Ok"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
}
