import 'package:flutter/material.dart';

class LayoutingDay5 extends StatelessWidget {
  const LayoutingDay5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            //Warna dari Basenya Flutter
            //  Colors.red,
            //Warna ARGB
            // const Color.fromARGB(255, 117, 102, 101),
            //Warna HEX
            Color(0xff90B800),

        title: Text("Layouting Day 5"),
        centerTitle: true,
        actions: [Text("1"), Text("2")],
        leading: Icon(Icons.arrow_back),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        //  mainAxisSize: MainAxisSize.max,
        spacing: 20,
        children: [
          Text("Hello Batch 7"),
          Text("Hello Batch 7"),
          Text("Hello Batch 7"),
          Icon(Icons.star),
          Text("Hello Batch 7"),
          Text("Di bawah ini Row"),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [Icon(Icons.star), Text("Hello Batch 7")],
          ),
        ],
      ),
    );
  }
}
