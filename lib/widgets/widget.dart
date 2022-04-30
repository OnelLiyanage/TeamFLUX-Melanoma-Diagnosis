// ignore_for_file: unnecessary_const

import "package:flutter/material.dart";

Widget appBarMain ( BuildContext context ) {
	return AppBar(
		title: Image.asset("assetss/images/logo.png",
		height: 50,
		) ,
	);
}

InputDecoration inputFeildDecoration (String hintText) {
	return InputDecoration(
		hintText: hintText,
		enabledBorder: const UnderlineInputBorder (
			borderSide: const BorderSide(color: Colors.grey),
		)
	);
}