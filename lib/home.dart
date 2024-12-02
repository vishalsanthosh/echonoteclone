import 'package:echonoteclone/note.dart';
import 'package:echonoteclone/list.dart';
import 'package:echonoteclone/task.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool _showIcon = false;
  bool _showFab = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Echo Note",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
            bottom: TabBar(tabs: [
              Tab(
                text: "Text",
              ),
              Tab(
                text: "List",
              ),
              Tab(
                text: "Task",
              )
            ]),
          ),
          floatingActionButton: _showFab
              ? (FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: () {
                    setState(() {
                      _showIcon = true;
                      _showFab = false;
                    });
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ))
              : null,
          body: TabBarView(children: [
            GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: 100,
                itemBuilder: (context, index) {
                  return Container(
                    height: 80,
                    width: 160,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(255, 252, 237, 107)),
                  );
                }),
            Stack(children: <Widget>[
              if (_showIcon)
                Positioned(
                  bottom: 60,
                  right: 15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 40),
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ThirdScreen()));
                          },
                          icon: Icon(Icons.check_circle_outline),
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SecondScreen()));
                          },
                          icon: Icon(Icons.check_box_rounded),
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FirstscreenExp()));
                          },
                          icon: Icon(Icons.menu),
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
            ])
          ])),
    );
  }
}
