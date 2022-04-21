import 'package:chat_ui/helper/authenticate.dart';
import 'package:chat_ui/screens/signin.dart';
import 'package:chat_ui/screens/signup.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
		await Firebase.initializeApp();
	runApp(Melano());
}

class Melano extends StatelessWidget {
	Melano({Key? key}) : super(key: key);

	// This widget is the root of your application.
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Flutter Demo',
			debugShowCheckedModeBanner: false,
			theme: ThemeData(
				// primarySwatch: Colors.blue,
                // primaryColor: Colors.white,
               brightness: Brightness.light,
               backgroundColor: Colors.white
			),
			home: Authenticate(),
		);
	}
}
