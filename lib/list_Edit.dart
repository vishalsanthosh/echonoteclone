import 'package:echonoteclone/database.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class ListEditScreen extends StatefulWidget {
  final String title;
  final List<dynamic> content;
  final String id;
  const ListEditScreen(
      {super.key,
      required this.title,
      required this.content,
      required this.id});
  @override
  State<ListEditScreen> createState() => _ListEditScreenState();
}

class _ListEditScreenState extends State<ListEditScreen> {
  late TextEditingController listC;
  late TextEditingController addList;
  void _removeList(int index) {
    setState(() {
      _listS.removeAt(index);
    });
  }

  void initState() {
    super.initState();
    listC = TextEditingController(text: widget.title);
    addList = TextEditingController();
    _listS = List<String>.from(widget.content);
  }

  @override
  void dispose() {
    listC.dispose();
    addList.dispose();
    super.dispose();
  }

  List<String> _listS = [];
  void _addTextToList() {
    setState(() {
      if (addList.text.isNotEmpty) {
        _listS.add(addList.text);
        addList.clear();
      }
    });
  }

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
                  Map<String, dynamic> updateInfo = {
                    "title": listC.text,
                    "content": _listS,
                    "Id": widget.id,
                  };
                  await Database.updateListDetails(widget.id, updateInfo);
                  Navigator.of(context).pop();
                  listC.clear();
                  addList.clear();
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
                        onPressed: () {
                          _addTextToList();
                        },
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
                      itemCount: _listS.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_listS[index]),
                          trailing: IconButton(
                              onPressed: () {
                                _removeList(index);
                              },
                              icon: Icon(Icons.cancel_outlined)),
                        );
                      }))
            ],
          ),
        ));
  }
}
