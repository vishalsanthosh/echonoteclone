import 'package:echonoteclone/database.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final listC = TextEditingController();
  final addList = TextEditingController();
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
            "Add New List",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  String id = randomAlphaNumeric(10);
                  Map<String, dynamic> listInfoMap = {
                    "title": listC.text,
                    "content": addList.text,
                    "Id": id,
                  };
                  await Database.addTextDetails(listInfoMap, id);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("List Added"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  listC.clear();
                                  addList.clear();
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
                controller: listC,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    label: Text("Title", style: TextStyle(color: Colors.green)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: addList,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add,
                          color: Colors.green,
                        )),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    label: Text("Add to List",
                        style: TextStyle(color: Colors.green)),
                    alignLabelWithHint: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(addList.text),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.cancel_outlined)),
                        );
                      }))
            ],
          ),
        ));
  }
}
