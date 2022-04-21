import 'package:flutter/material.dart';

class Reminderpage extends StatefulWidget {
  const Reminderpage({ Key? key }) : super(key: key);

  @override
  State<Reminderpage> createState() => _ReminderpageState();
}

class _ReminderpageState extends State<Reminderpage> {
    List reminders = [];
    String input = "";

    @override
    void initState() {
        super.initState();
  }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
				title: Text (
                    "Reminders",
                    style: TextStyle (
                        color: Colors.white,
                    ),
                ),
                backgroundColor: Color.fromRGBO(49, 163, 139, 0.663),
                elevation: 0,
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                    showDialog(context: context, builder: (BuildContext context){
                        return AlertDialog(
                            title: Text("Add to Reminders"),
                            content: TextField(
                                onChanged: (String value){
                                    input = value;
                                },
                            ),
                            actions: <Widget>[
                                FlatButton (
                                    onPressed: (){
                                    setState(() {
                                        reminders.add(input);
                                    });
                                    Navigator.of(context).pop();
                                    }, 
                                    child: Text("Add") 
                                )
                            ],
                        );
                    } );
                },
                child: Icon(
                    Icons.add, 
                    color: Colors.white
                ) 
            ),
            body: ListView.builder(
                itemCount: reminders.length ,itemBuilder: (BuildContext context, int index) {
                    return Dismissible( 
                        key: Key (reminders[index] ), 
                        child: Card(
                            child: ListTile(
                                title: Text(reminders[index]),
                                trailing: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red), 
                                    onPressed: (){
                                        setState(() {
                                            reminders.removeAt(index);             
                                        });
                                    }
                                ),
                            ),
                        )
                    );
                }
            )
        );
    }
}