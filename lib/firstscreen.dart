import 'package:flutter/material.dart';

class FirstscreenExp extends StatefulWidget {
  const FirstscreenExp({super.key});

  @override
  State<FirstscreenExp> createState() => _FirstscreenExpState();
}

class _FirstscreenExpState extends State<FirstscreenExp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hi"),
      ),
    );
  }
}
