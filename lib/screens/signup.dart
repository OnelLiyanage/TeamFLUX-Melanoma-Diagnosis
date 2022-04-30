import 'package:chat_ui/screens/homescreen.dart';
import 'package:chat_ui/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:chat_ui/services/authentication.dart';
import 'package:chat_ui/services/database.dart';
class SignUp extends StatefulWidget {
  
  final	Function toggle;
  SignUp(this.toggle, {Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isLoading = false;
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  final	formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  final	
  RegExp _email = RegExp(           // Expression to match email comnbination
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

        databaseMethods.uploadUserInfo(userInfoMap);
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => const Homescreen()
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
        child: const Center (
          child: CircularProgressIndicator()
          ), 
        ) : SingleChildScrollView(
                        child: Container(
                            alignment: Alignment.bottomCenter,
                                child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                    child: Column (
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                            Form(
                                                key: formKey,
                                            child: Column(
                                            children: [
                                            const SizedBox(height: 40.0),
                                                TextFormField(
                                                    validator: (val) {
                                                        return val!.isEmpty || val.length < 3 ? "Username should contain a minimum of 3 characters." : null ;
                                                    },
                                                    controller: userNameTextEditingController,
                                                    decoration: inputFeildDecoration ("Username"),
                                                ),
                                                const SizedBox(height: 20.0),

                                                TextFormField(
                                                    validator: (val) {
                                                        return _email.hasMatch(val!) ? null : "Invalid Email";
                                                    },
                                                    controller: emailTextEditingController,
                                                    decoration: inputFeildDecoration ("Email"),
                                                ),
                                                const SizedBox(height: 20.0),

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
                                        const SizedBox(height: 20.0),

                                        const SizedBox( height: 20.0,),

                                        GestureDetector(
                                            onTap: () {
                                                signUpUser();
                                            },
                                            child: Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context).size.width,
                                                padding: const EdgeInsets.symmetric(vertical: 20),
                                                decoration: BoxDecoration(
                                                    gradient: const LinearGradient (
                                                        colors:  [
                                                            Color.fromARGB(169, 49, 163, 139),
                                                            Color.fromARGB(178, 49, 163, 138), 
                                                            ]
                                                    ),
                                                    borderRadius: BorderRadius.circular(25)
                                                ),
                                                child: const Text (
                                                    "Sign Up",
                                                    style: TextStyle (
                                                        fontSize: 18.0,
                                                        color: Colors.white,
                                                    ),
                                                ),
                                            ),
                                        ),

                                        const SizedBox(height: 20.0),
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                                const Text ("Have an account? "),
                                                GestureDetector ( 
                                                    onTap : () {
                                                        widget.toggle();
                                                    } ,
                                                child: Container(
                                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                child: const Text(
                                                    " Login here ",
                                                    style: TextStyle (
                                                        decoration: TextDecoration.underline
                                                    ),
                                                    ),
                                                ),
                                            )
                                            ],
                                        ),
                                        const SizedBox(height: 10.0),
                                        ],
                                    ),
                                    ),
                                    ),
                                ),
    );
  }
}
