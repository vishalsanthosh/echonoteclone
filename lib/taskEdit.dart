import 'package:echonoteclone/database.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class EditTask extends StatefulWidget {
  final String title;
  final String content;
  final String id;

  const EditTask(
      {super.key,
      required this.title,
      required this.content,
      required this.id});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late TextEditingController taskC;
  late TextEditingController desC;

  void initState() {
    super.initState();
    taskC = TextEditingController(text: widget.title);
    desC = TextEditingController(text: widget.content);
  }

  @override
  void dispose() {
    taskC.dispose();
    desC.dispose();
    super.dispose();
  }

  final DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text(
            "Add New Task",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  String id = randomAlphaNumeric(10);
                  Map<String, dynamic> updateInfo = {
                    "title": taskC.text,
                    "content": desC.text,
                    "Id": widget.id,
                  };
                  await Database.updateTaskDetails(widget.id, updateInfo)
                      .then((value) {
                    Navigator.pop(context);
                  });
                  Navigator.of(context).pop();
                                  taskC.clear();
                                  desC.clear();
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
                controller: taskC,
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
                maxLines: 20,
                controller: desC,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    label: Text("Description",
                        style: TextStyle(color: Colors.green)),
                    alignLabelWithHint: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "${dateTime.day.toString()}-${dateTime.month.toString()}-${dateTime.year.toString()}",
                    style: TextStyle(color: Colors.green),
                  ),
                  Spacer(),
                  Text(
                    "${dateTime.hour.toString()}:${dateTime.minute.toString()}",
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
