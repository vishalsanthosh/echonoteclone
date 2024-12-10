import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echonoteclone/database.dart';
import 'package:echonoteclone/text_Edit.dart';
import 'package:echonoteclone/text_ui.dart';
import 'package:flutter/material.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  Stream<QuerySnapshot>? NoteStream;
  getontheload() async {
    NoteStream = await Database.getTextDetails();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getontheload();
  }

  Widget allNoteDetails() {
    return StreamBuilder(
        stream: NoteStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error:${snapshot.error}"),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(""),
            );
          }
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.3,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data!.docs[index];
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 218, 154, 153),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  (ds['title'] ?? "N/A"),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              Spacer(),
                              PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == "Edit") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditTextScreen(
                                                    title: ds['title'],
                                                    content: ds['content'],
                                                    id: ds["Id"],
                                                  )));
                                    } else if (value == "Delete") {
                                      Database.deleteTextDetails(ds['Id']);
                                    }
                                  },
                                  itemBuilder: (context) => [
                                        PopupMenuItem(
                                            value: "Edit", child: Text("Edit")),
                                        PopupMenuItem(
                                            value: "Delete",
                                            child: Text("Delete"))
                                      ])
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            (ds["content"] ?? "N/A").toString(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Expanded(child: allNoteDetails())],
      ),
    );
  }
}
