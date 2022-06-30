import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'algoscreen.dart';

void main() {
  runApp(MaterialApp(
    home: mergesort(),
  ));
}

class mergesort extends StatefulWidget {
  const mergesort({Key? key}) : super(key: key);

  @override
  _mergesortState createState() => _mergesortState();
}

class _mergesortState extends State<mergesort> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueAccent.shade400,
          title: Text(
            'Merge Sort',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            height: 250,
            color: Color(0xffEFEAD8),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            height: 300,
            color: Color(0xffEFEAD8),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Material(
                child: IconButton(
                  iconSize: 35,
                  color: Colors.lightBlue,
                  onPressed: () {},
                  icon: Icon(Icons.skip_previous),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Material(
                child: IconButton(
                  iconSize: 35,
                  color: Colors.lightBlue,
                  onPressed: () {},
                  icon: Icon(Icons.pause),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Material(
                child: IconButton(
                  iconSize: 35,
                  color: Colors.lightBlue,
                  onPressed: () {},
                  icon: Icon(Icons.skip_next),
                ),
              ),
            ]),
          ),
        ],
      )),
    );
  }
}
