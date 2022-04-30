import 'package:flutter/material.dart';

class AboutMelano extends StatefulWidget {
    const AboutMelano({ Key? key }) : super(key: key);

    @override
    State<AboutMelano> createState() => _AboutMelanoState();
}

class _AboutMelanoState extends State<AboutMelano> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
		    	title: const Text (
                    "Previous Scans",
                    style: TextStyle (
                        color: Colors.white,
                    ),
                ),
                backgroundColor: const Color.fromRGBO(49, 163, 139, 0.663),
                elevation: 0,
            ),
            body: Container (
                child: const Center(
                    child: Text(
                        "Melano is a chatbot that analyses a photograph through Machine learning and advanced Image Processing to scan symptoms of Melanoma skin cancer."
                        "In order to deliver an accurate prediction, the images uploaded by the user must be well lit and generally detailed."
                        "Once the scanning is finished the results will be displayed as an overall percentage of the possibility of being recognised as cancer."
                        "Following the results (is the option to get assistance by a virtual) the chatbot provides the user with more information about their condition and guides them with further steps..",
                        style: TextStyle(
                            letterSpacing: 2.0,
                            
                        ),
                    )
                ),
            ),
        );
    }
}