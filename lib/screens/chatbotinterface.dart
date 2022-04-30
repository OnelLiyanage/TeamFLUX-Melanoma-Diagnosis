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

class Chatbotinterface extends StatefulWidget {
  const Chatbotinterface({Key? key}) : super(key: key);

    @override
    _Chatbotinterface createState() => _Chatbotinterface();
}

class _Chatbotinterface extends State<Chatbotinterface> {
    File? selectedImage;
    final picker = ImagePicker();
    String? message = " " ;

//  Dialogflow API call
// Sets the language as eng and Json key file  
    void response(query) async {
		AuthGoogle authGoogle = await AuthGoogle(
            fileJson: "assets/melano-chatbot-lqci-b6060c1d3e0c.json"
		) .build() ;
        DialogFlow dialogflow = DialogFlow( authGoogle: authGoogle, language: Language.english);
		AIResponse aiResponse = await dialogflow.detectIntent(query);
		setState(() {
			messages.insert(0, {
				"data": 0,                  // 0 assinged to chatbot, styling is assinged accordingly
				"message": aiResponse.getListMessage()![0]["text"]["text"][0].toString()
			} );
		} );

        print( aiResponse.getListMessage()![0]["text"]["text"][0].toString() );	
	}

    final messageInsert = TextEditingController();
    List<Map> messages = [ ];
    

    // method to load the image from gallery 
    Future getImage() async {
        // ignore: deprecated_member_use
        final pickedImage = await picker.getImage(source: ImageSource.gallery);
        selectedImage = File(pickedImage!.path);
        setState(() {});
    }

    // API to upload the image to the ML server 
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
        print(message);                                                                             // prints the value from server to the console
        double message_value =  double.parse(message!) ;
        double a = message_value*100;
        print(a);
        setState(() {});
    } 

    @override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text (
                    "Scan",
                    style: TextStyle (
                        color: Colors.white,
                    ),
                ),
                backgroundColor: const Color.fromRGBO(49, 163, 139, 0.663),
                elevation: 0,
            ),

			body: Container ( 
				child: Column (
					children: <Widget> [
						Flexible(child: ListView.builder  (
							reverse:  true,
							itemCount: messages.length,
							itemBuilder: (context, index) => chat (
								messages[index] ["message"].toString(),
								messages[index] ["data"]
							)
						)
						),

						// image picker displays the selected image and the value returned from ML server
                        selectedImage == null 
                            ? const Text("No Images Selected ")
                            : Image.file(selectedImage!) , Text (message!),
                        IconButton(
                            onPressed: uploadeImage,
                            icon: const Icon(Icons.upload) 
                        ),

						const Divider( 
							height: 5.0,
						),

                    // section with gallery icon and text feild to type questions for the chat bot
					Container(
						child: ListTile (
							title: Container (
								height: 35,
								decoration:  const BoxDecoration (
									borderRadius: BorderRadius.all(Radius.circular(15)),
									color: Color.fromRGBO(220, 220, 220, 1),
								),

								padding: const EdgeInsets.only(left: 15),
								child: TextFormField (
									controller: messageInsert,
									decoration: const InputDecoration (
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

									style: const TextStyle (
										fontSize: 15,
										color: Colors.black
									),

									onChanged: (value) { },

									),
								),
 
								leading: IconButton ( 
                                    icon: const Icon (
                                        Icons.image_outlined,
                                        size: 28.0,
                                    ),
                                    onPressed : 
                                        getImage,    
							    ),

								trailing: IconButton (
									icon:  const Icon(
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

						const SizedBox( height: 47.0 )

					],
				),
			),
		);
	}

    // chat bubble style
    //  depending on data value (0/1)
    // 0 = chatbot, 1 = user 
	Widget chat (String message, int data) {
		return Container(
			padding: const EdgeInsets.only(left: 10, right: 10),
			child: Row(
				mainAxisAlignment: data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
				children: [
					data == 0 ? Container(
						height: 40.0,
						width: 40.0,
						child: const CircleAvatar (
							backgroundImage: AssetImage ("assets/images/Logo-draft-clear-2.png"),
						)
					) : Container(),

					Padding (
						padding: const EdgeInsets.all(5.0),
						child: Bubble (
							radius: const Radius.circular(5.0),
							color: data==0 ? const Color.fromARGB(255, 49, 163, 138) : const Color.fromARGB(255, 49, 135, 192),
							elevation: 0.0,

							child:  Padding (
								padding: const EdgeInsets.all(2.0),
								child: Row(
									mainAxisSize: MainAxisSize.min,
									children: <Widget> [
										const SizedBox( width: 10.0 ),

										Flexible(
											child: Container (
												constraints: const BoxConstraints (maxWidth: 200),
												child: Text (
													message,
													style: const TextStyle (
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
