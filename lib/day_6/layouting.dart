import 'package:flutter/material.dart';

class LayoutingDay6 extends StatelessWidget {
  const LayoutingDay6({super.key});

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

        title: Text("Layouting Day 6"),
        centerTitle: true,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        // spacing: 20,
        children: [
          //Penggunaan SizedBox
          Text("Hello Batch 7"),
          SizedBox(height: 40),
          Text("Hello Batch 7"),
          SizedBox(height: 20),

          Text("Hello Batch 7"),
          Row(
            children: [
              Icon(Icons.star),
              SizedBox(width: 20),
              Text("Hello Batch 7"),
            ],
          ),
          Row(children: [Icon(Icons.star), Text("Hello Batch 7")]),
          SizedBox(
            height: 50,
            child: Row(children: [Icon(Icons.star), Text("Hello Batch 7")]),
          ),
          Row(children: [Icon(Icons.star), Text("Dibawah ini Padding")]),

          //Penggunaan Padding
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                // Text("Ini Penggunaan Padding"),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Row(
              children: [
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                // Text("Ini Penggunaan Padding"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
