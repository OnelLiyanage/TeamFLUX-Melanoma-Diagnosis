import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:dialogflow_flutter/dialogflowFlutter.dart';
import 'package:dialogflow_flutter/googleAuth.dart';
import 'package:dialogflow_flutter/language.dart';

class MyHomePage extends StatefulWidget {
	// MyHomePage({  Key? key,  required this.title }) : super(key: key);
	// final String title ;

    @override
    _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    File? selectedImage;
    final picker = ImagePicker();
    String? message = " " ;

// this is the Dialogflow API call and its commented out for the Python file @Nemsara 
    void response(query) async {
		AuthGoogle authGoogle = await AuthGoogle(
            fileJson: "assets/melano-chatbot-lqci-b6060c1d3e0c.json"
		) .build() ;
        DialogFlow dialogflow = DialogFlow( authGoogle: authGoogle, language: Language.english);
		AIResponse aiResponse = await dialogflow.detectIntent(query);
		setState(() {
			messages.insert(0, {
				"data": 0,
				"message": aiResponse.getListMessage()![0]["text"]["text"][0].toString()
			} );
		} );

        print( aiResponse.getListMessage()![0]["text"]["text"][0].toString() );	
	}

    final messageInsert = TextEditingController();
    List<Map> messages = [ ];
    

    // loading the image 
    Future getImage() async {
        // ignore: deprecated_member_use
        final pickedImage = await picker.getImage(source: ImageSource.gallery);
        selectedImage = File(pickedImage!.path);
        setState(() {});
    }

    //uploading the image 
    uploadeImage() async {
        final request = http.MultipartRequest("POST", Uri.parse("https://melanoma-test.azurewebsites.net/predict"));
        final headers = { "Content-type": "multipart/form-data" };
        
        request.files.add (
            http.MultipartFile('image', selectedImage!.readAsBytes().asStream(),selectedImage!.lengthSync(),
            filename: selectedImage!.path.split("/").last)
        );
    
        request.headers.addAll(headers);
        final response = await request.send();
        http.Response res = await http.Response.fromStream(response);
        final resJson = jsonDecode(res.body );
        message = resJson['prediction'];
        print(message);
        double message_value =  double.parse(message!) ;
        double a = message_value*100;
        print(a);
        setState(() {});
    } 

    @override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text (
                    "Scan",
                    style: TextStyle (
                        color: Colors.white,
                    ),
                ),
                backgroundColor: Color.fromRGBO(49, 163, 139, 0.663),
                elevation: 0,
            ),

			body: Container ( 
				child: Column (
					children: <Widget> [

            // ignore: prefer_const_constructors
            // Nems edit
            // if (selectedImage == null) Text("Choose an image to uploade") else Image.file(selectedImage!);
            
						Flexible(child: ListView.builder  (
							reverse:  true,
							itemCount: messages.length,
							itemBuilder: (context, index) => chat (
								messages[index] ["message"].toString(),
								messages[index] ["data"]
							)
						)
						),

						// SizedBox( height: 20.0 ),
                        selectedImage == null 
                            ? const Text("No Images Selected ")
                            : Image.file(selectedImage!) , Text (message!),
                        IconButton(
                            onPressed: uploadeImage,
                            icon: const Icon(Icons.upload) 
                        ),

						Divider( 
							height: 5.0,
						),

					Container(
						child: ListTile (
							title: Container (
								height: 35,
								decoration:  BoxDecoration (
									borderRadius: BorderRadius.all(Radius.circular(15)),
									color: Color.fromRGBO(220, 220, 220, 1),
								),

								padding: EdgeInsets.only(left: 15),
								child: TextFormField (
									controller: messageInsert,
									decoration: InputDecoration (
										hintText: "Ask your question here...",
										hintStyle: TextStyle (
											color:  Colors.black45
										),
										
										border:  InputBorder.none,
										focusedBorder: InputBorder.none,
										enabledBorder: InputBorder.none,
										errorBorder: InputBorder.none,
										disabledBorder: InputBorder.none,
									),

									style: TextStyle (
										fontSize: 15,
										color: Colors.black
									),

									onChanged: (value) { },

									),
								),
 
								leading: IconButton ( 
                                    icon: Icon (
                                        Icons.camera_alt,
                                        size: 28.0,
                                    ),
                                    onPressed : 
                                        getImage,    
							    ),

								trailing: IconButton (
									icon:  Icon(
										Icons.send,
										size: 30.0,
									),

									onPressed: () { 
										if (messageInsert.text.isEmpty) {
											print("Message is Empty");
                      
										} else {
											setState( () {
											messages.insert(0,
													{ "data" : 1, "message" : messageInsert.text } );
											} );

											response(messageInsert.text);
											messageInsert.clear();
										}

										FocusScopeNode currentFocus = FocusScope.of(context);
										if ( !currentFocus.hasPrimaryFocus ) {
											currentFocus.unfocus();
										}
									}
								),
							),
						),

						SizedBox( height: 47.0 )

					],
				),
			),
		);
	}

	Widget chat (String message, int data) {
		return Container(
			padding: EdgeInsets.only(left: 10, right: 10),
			child: Row(
				mainAxisAlignment: data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
				children: [
					data == 0 ? Container(
						height: 40.0,
						width: 40.0,
						child: CircleAvatar (
							backgroundImage: AssetImage ("assets/images/Logo-draft-clear-2.png"),
						)
					) : Container(),

					Padding (
						padding: EdgeInsets.all(5.0),
						child: Bubble (
							radius: Radius.circular(5.0),
							color: data==0 ? Color.fromARGB(255, 49, 163, 138) : Color.fromARGB(255, 49, 135, 192),
							elevation: 0.0,

							child:  Padding (
								padding: EdgeInsets.all(2.0),
								child: Row(
									mainAxisSize: MainAxisSize.min,
									children: <Widget> [
										SizedBox( width: 10.0 ),

										Flexible(
											child: Container (
												constraints: BoxConstraints (maxWidth: 200),
												child: Text (
													message,
													style: TextStyle (
														color: Colors.white,
														fontWeight: FontWeight.bold,
													),
												),
											)
										)
									],
								),
							)
						),
					),

					data == 1 
                        ? Container () 
                        : Container() ,
				],
			),
		);
	}
}
