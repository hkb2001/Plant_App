import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/screens/details/components/heart.dart';

// ignore: camel_case_types
class addnote extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _addnoteState createState() => _addnoteState();
}

// ignore: camel_case_types
class _addnoteState extends State<addnote> {
  TextEditingController second = TextEditingController();

  TextEditingController third = TextEditingController();

  final fb = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    var rng = Random();
    var k = rng.nextInt(10000);

    final ref = fb.ref().child('todos/$k');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todos"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(border: Border.all()),
            child: TextField(
              controller: second,
              decoration: const InputDecoration(
                hintText: 'title',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(border: Border.all()),
            child: TextField(
              controller: third,
              decoration: const InputDecoration(
                hintText: 'sub title',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialButton(
            color: Colors.green,
            onPressed: () {
              ref.set({
                "title": second.text,
                "subtitle": third.text,
              }).asStream();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const HeartScreen()));
            },
            child: const Text(
              "save",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
