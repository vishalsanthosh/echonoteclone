import 'package:echonoteclone/database.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class EditTextScreen extends StatefulWidget {
  final String title;
  final String content;
  final String id;

  const EditTextScreen(
      {super.key,
      required this.title,
      required this.content,
      required this.id});

  @override
  State<EditTextScreen> createState() => _EditTextScreenState();
}

class _EditTextScreenState extends State<EditTextScreen> {
  late TextEditingController titleC;
  late TextEditingController contentC;

  void initState() {
    super.initState();
    titleC = TextEditingController(text: widget.title);
    contentC = TextEditingController(text: widget.content);
  }

  @override
  void dispose() {
    titleC.dispose();
    contentC.dispose();
    super.dispose();
  }

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
            "Edit Note",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
          actions: [
            IconButton(
                onPressed: () async {
                  String id = randomAlphaNumeric(10);
                  Map<String, dynamic> updateInfo = {
                    "title": titleC.text,
                    "content": contentC.text,
                    "Id": widget.id,
                  };
                  await Database.updateTextDetails(widget.id, updateInfo)
                      .then((value) {
                    Navigator.pop(context);
                  });
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Note Edited"),
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
