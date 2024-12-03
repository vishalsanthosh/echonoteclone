import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Database {
  static Future addTaskDetails(
      Map<String, dynamic> taskInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Task")
        .doc(id)
        .set(taskInfoMap);
  }

  static Future<Stream<QuerySnapshot>> getTaskDetails() async {
    return await FirebaseFirestore.instance.collection("Task").snapshots();
  }

  static Future updateTaskDetails(
      String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("Task")
        .doc(id)
        .update(updateInfo);
  }

  static Future deleteTaskDetails(String id) async {
    return await FirebaseFirestore.instance.collection("Task").doc(id).delete();
  }

  //TEXt
  static Future addTextDetails(
      Map<String, dynamic> textInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Text")
        .doc(id)
        .set(textInfoMap);
  }

  static Future<Stream<QuerySnapshot>> getTextDetails() async {
    return await FirebaseFirestore.instance.collection("Text").snapshots();
  }

  static Future updateTextDetails(
      String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("Text")
        .doc(id)
        .update(updateInfo);
  }

  static Future deleteTextDetails(String id) async {
    return await FirebaseFirestore.instance.collection("Text").doc(id).delete();
  }

  //List
  static Future addListDetails(
      Map<String, dynamic> listInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("List")
        .doc(id)
        .set(listInfoMap);
  }

  static Future<Stream<QuerySnapshot>> getListDetails() async {
    return await FirebaseFirestore.instance.collection("List").snapshots();
  }

  static Future updateListDetails(
      String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("List")
        .doc(id)
        .update(updateInfo);
  }

  static Future deleteListDetails(String id) async {
    return await FirebaseFirestore.instance.collection("List").doc(id).delete();
  }
}
