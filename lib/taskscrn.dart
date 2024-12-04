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
              child: Text("No Task Available"),
            );
          }
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.8,
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
                              Text(
                                (ds['title'] ?? "N/A"),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
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
                                                  EditTask()));
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
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            (ds["content"] ?? "N/A").toString(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
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
        children: [Expanded(child: allTaskDetails())],
      ),
    );
  }
}
