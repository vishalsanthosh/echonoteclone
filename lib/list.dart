import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:echonoteclone/database.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final listC = TextEditingController();  
  final addList = TextEditingController();
  List<String> _listS = [];

  
  void _removeList(int index) {
    setState(() {
      _listS.removeAt(index);
    });
  }

  
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
          ),
        ),
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
                "head": addList.text, 
                "content": _listS, 
                "Id": id, 
              };
             
              await Database.addListDetails(listInfoMap, id);
              Navigator.of(context).pop(); 
              listC.clear(); 
              addList.clear(); 
            },
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
          )
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
                    borderSide: BorderSide(color: Colors.green)),
              ),
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
                  ),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
                label: Text("Add to List",
                    style: TextStyle(color: Colors.green)),
                alignLabelWithHint: true,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
              ),
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
                      icon: Icon(Icons.cancel_outlined),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
