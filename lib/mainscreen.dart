import 'package:echonoteclone/firstscreen.dart';
import 'package:echonoteclone/secondsn.dart';
import 'package:echonoteclone/thirdsn.dart';
import 'package:flutter/material.dart';

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
          body: TabBarView(
              children: [FirstscreenExp(), SecondScreen(), ThirdScreen()]),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () {},
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
          )),
    );
  }
}
