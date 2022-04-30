// ignore_for_file: prefer_const_constructors
import 'package:chat_ui/helper/authenticate.dart';
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

	// Root of the app.
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Flutter Demo',
			debugShowCheckedModeBanner: false,
			theme: ThemeData(
               brightness: Brightness.light,
               backgroundColor: Colors.white
			),
			home: Authenticate(),
		);
	}
}
