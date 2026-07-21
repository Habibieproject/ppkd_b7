import 'package:flutter/material.dart';

class StylingDay5 extends StatelessWidget {
  const StylingDay5({super.key});

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

        title: Text("Styling Day 5"),
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
          Text(
            "Hello Batch 7",
            style: TextStyle(
              fontSize: 50, //Ukuran Font
              fontWeight: FontWeight.bold, //Ketebalan
              color: Colors.red, // Warna Font
            ),
          ),

          Text(
            "Hello Batch 7",
            style: TextStyle(
              fontSize: 50, //Ukuran Font
              fontWeight: FontWeight.bold, //Ketebalan
              color: Colors.red, // Warna Font
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dotted,
              decorationColor: Colors.blue,
            ),
          ),

          Text(
            "Hello Batch 7",
            style: TextStyle(
              fontSize: 50, //Ukuran Font
              fontWeight: FontWeight.bold, //Ketebalan
              color: Colors.red, // Warna Font
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dotted,
              decorationColor: Colors.blue,
              backgroundColor: Colors.amberAccent,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
