import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echonoteclone/database.dart';
import 'package:echonoteclone/task.dart';
import 'package:echonoteclone/taskEdit.dart';
import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  Stream<QuerySnapshot>? TaskStream;
  final DateTime dateTime = DateTime.now();
  getontheload() async {
    TaskStream = await Database.getTaskDetails();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getontheload();
  }

  Widget allTaskDetails() {
    return StreamBuilder(
        stream: TaskStream,
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
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blue[200],
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
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Spacer(),
                              PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == "Edit") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EditTask(
                                                    title: ds["title"],
                                                    content: ds["content"],
                                                    id: ds["Id"],
                                                  )));
                                    } else if (value == "Delete") {
                                      Database.deleteTaskDetails(ds['Id']);
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
                          Text(
                            "${dateTime.day.toString()}-${dateTime.month.toString()}-${dateTime.year.toString()} ${dateTime.hour}:${dateTime.minute}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Flexible(
                            child: Text(
                              (ds["content"] ?? "N/A").toString(),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Task Ended",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          )
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
        children: [Expanded(child: allTaskDetails())],
      ),
    );
  }
}
