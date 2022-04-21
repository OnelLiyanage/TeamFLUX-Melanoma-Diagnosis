import 'package:chat_ui/screens/homescreen.dart';
import 'package:chat_ui/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:chat_ui/services/authentication.dart';
import 'package:chat_ui/services/database.dart';
class SignUp extends StatefulWidget {
  
  final	Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final	formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  final	
  RegExp _email = RegExp(
    r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");

  signUpUser() {
    if (formKey.currentState!.validate()) {
      
      Map<String, String> userInfoMap = {
          "name" : userNameTextEditingController.text,
          "email" : emailTextEditingController.text
        };
        
      setState(() {
        isLoading = true; 
      });

      authMethods.signUpwithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((val) {
        // print("${val.userId}");

        databaseMethods.uploadUserInfo(userInfoMap);
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => ChatRoom()
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold (
    appBar: AppBar (
      title: Center(
        child: Image.asset("assets/images/AppBar2.png",
        height: 30,
        ),
      ),
            backgroundColor: Colors.white,
            elevation: 0,
    ),
      
      body: isLoading ? Container (
        child: Center (
          child: CircularProgressIndicator()
          ), 
        ) : SingleChildScrollView(
                        child: Container(
                            alignment: Alignment.bottomCenter,
                                child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                                    child: Column (
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                            Form(
                                                key: formKey,
                                            child: Column(
                                            children: [
                                            SizedBox(height: 40.0),
                                                TextFormField(
                                                    validator: (val) {
                                                        return val!.isEmpty || val.length < 3 ? "Username should contain a minimum of 3 characters." : null ;
                                                    },
                                                    controller: userNameTextEditingController,
                                                    decoration: inputFeildDecoration ("Username"),
                                                ),
                                                SizedBox(height: 20.0),

                                                TextFormField(
                                                    validator: (val) {
                                                        return _email.hasMatch(val!) ? null : "Invalid Email";
                                                    },
                                                    controller: emailTextEditingController,
                                                    decoration: inputFeildDecoration ("Email"),
                                                ),
                                                SizedBox(height: 20.0),

                                                TextFormField(
                                                    obscureText: true,
                                                    validator: (val) {
                                                        return val!.length > 6 ? null : "Password should contain more than 6 characters." ;
                                                    },
                                                    controller: passwordTextEditingController,
                                                    decoration: inputFeildDecoration ("Password"),
                                                ),
                                            ],
                                            ),
                                        ),
                                        SizedBox(height: 20.0),

                                        // Container(
                                        // 	child: Container ( 
                                        // 		alignment: Alignment.centerRight,
                                        // 		padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                        // 		child: Text (
                                        // 			"Forgot Password",
                                        // 			style: TextStyle (
                                        // 				fontSize: 14.0
                                        // 			),
                                        // 		),
                                        // 	),
                                        // ),
                                        SizedBox( height: 20.0,),

                                        GestureDetector(
                                            onTap: () {
                                                signUpUser();
                                            },
                                            child: Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context).size.width,
                                                padding: EdgeInsets.symmetric(vertical: 20),
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient (
                                                        colors:  [
                                                            const Color.fromARGB(169, 49, 163, 139),
                                                            const Color.fromARGB(178, 49, 163, 138), 
                                                            ]
                                                    ),
                                                    borderRadius: BorderRadius.circular(25)
                                                ),
                                                child: Text (
                                                    "Sign Up",
                                                    style: TextStyle (
                                                        fontSize: 18.0,
                                                        color: Colors.white,
                                                    ),
                                                ),
                                            ),
                                        ),

                                        SizedBox(height: 20.0),
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                                Text ("Have an account? "),
                                                GestureDetector ( 
                                                    onTap : () {
                                                        widget.toggle();
                                                    } ,
                                                child: Container(
                                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                                child: Text(
                                                    " Login here ",
                                                    style: TextStyle (
                                                        decoration: TextDecoration.underline
                                                    ),
                                                    ),
                                                ),
                                            )
                                            ],
                                        ),
                                        SizedBox(height: 10.0),
                                        ],
                                    ),
                                    ),
                                    ),
                                ),
    );
  }
}
