import 'package:echonoteclone/database.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final taskC = TextEditingController();
  final desC = TextEditingController();
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
                  Map<String, dynamic> taskInfoMap = {
                    "title": taskC.text,
                    "content": desC.text,
                    "Id": id,
                  };
                  await Database.addTaskDetails(taskInfoMap, id);
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
