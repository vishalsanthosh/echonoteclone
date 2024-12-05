import 'package:echonoteclone/database.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class FirstscreenExp extends StatefulWidget {
  const FirstscreenExp({super.key});

  @override
  State<FirstscreenExp> createState() => _FirstscreenExpState();
}

class _FirstscreenExpState extends State<FirstscreenExp> {
  final titleC = TextEditingController();
  final contentC = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text(
            "Add New Note",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
          actions: [
            IconButton(
                onPressed: () async {
                  String id = randomAlphaNumeric(10);
                  Map<String, dynamic> textInfoMap = {
                    "title": titleC.text,
                    "content": contentC.text,
                    "Id": id,
                  };
                  await Database.addTextDetails(textInfoMap, id);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Note Added"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  titleC.clear();
                                  contentC.clear();
                                },
                                child: Text("ok"))
                          ],
                        );
                      });
                },
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: titleC,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    label: Text("Title", style: TextStyle(color: Colors.green)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                maxLines: 30,
                controller: contentC,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    label:
                        Text("Content", style: TextStyle(color: Colors.green)),
                    alignLabelWithHint: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              )
            ],
          ),
        ));
  }
}
