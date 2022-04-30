// ignore_for_file: unnecessary_const

import 'package:chat_ui/helper/authenticate.dart';
import 'package:chat_ui/screens/aboutmelano.dart';
import 'package:chat_ui/screens/chatbotinterface.dart';
import 'package:chat_ui/screens/previousscans.dart';
import 'package:chat_ui/screens/reminderpage.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _Homescreen createState() => _Homescreen();
}

class _Homescreen extends State<Homescreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Center(
          child: Image.asset("assets/images/AppBar2.png",
          height: 30,
          ),
        ),
                backgroundColor: Colors.white,
                elevation: 0,
      ),

      body: Container(
          decoration: const BoxDecoration (
              gradient: const LinearGradient (
                  begin: Alignment.bottomLeft,
                  end: Alignment.topCenter,
                  colors: [
                      const Color.fromARGB(0, 35, 247, 208),
                      Color.fromRGBO(255, 255, 255, 100)
                  ],
              ),
          ),

        // 4 buttons to navigate the app  
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              GestureDetector(
                  onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const Chatbotinterface()
                      ));
                  },
                  child: const Center (
                      child: const Card (
                          margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                          child : Padding (
                              padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 25.0),
                          child: const Text (
                              "Scan for Melanoma",
                              style : TextStyle (
                                  fontSize: 18.0,
                                  color : Colors.black,
                                  ),
                              ),
                          ),
                      ),
                  ),
              ),
            GestureDetector(
                  onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const Previousscans()
                      ));
                  },
                  child: const Center (
                      child: Card (
                          margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child : Padding (
                              padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 25.0),
                          child: const Text (
                              "Previous Scan",
                              style : TextStyle (
                                  fontSize: 18.0,
                                  color : Colors.black,
                                  ),
                              ),
                          ),
                      ),
                  ),
              ),
            GestureDetector(
                  onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const Reminderpage()
                      ));
                  },
                  child: const Center (
                      child: Card (
                          margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child : Padding (
                              padding: EdgeInsets.symmetric(horizontal: 78.0, vertical: 25.0),
                          child: Text (
                              "Reminders",
                              style : const TextStyle (
                                  fontSize: 18.0,
                                  color : Colors.black,
                                  ),
                              ),
                          ),
                      ),
                  ),
              ),
              GestureDetector(
                  onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const AboutMelano()
                      ));
                  },
                  child: const Center (
                      child: const Card (
                          margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child : const Padding (
                              padding: EdgeInsets.symmetric(horizontal: 70.0, vertical: 25.0),
                          child: Text (
                              "About Melano",
                              style : TextStyle (
                                  fontSize: 18.0,
                                  color : Colors.black,
                                  ),
                              ),
                          ),
                      ),
                  ),
              ),
              
            //   SizedBox(height: 20.0),
          
          GestureDetector(
              onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
        			builder: (context) => const Authenticate() 
        			));
              },
                child: Container (
                    decoration: BoxDecoration (
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue[600]
                    ),
                    child: const Icon( Icons.logout ),
                ),
          ),
          ],
      ),
    )
    );
	}
  }