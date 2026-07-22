import 'package:flutter/material.dart';

class ExpandedDay6 extends StatelessWidget {
  const ExpandedDay6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expanded day 6"),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                // flex: 2,
                child: Container(height: 200, color: Colors.red),
              ),
              Expanded(child: Container(height: 200, color: Colors.yellow)),
              Expanded(child: Container(height: 200, color: Colors.green)),
            ],
          ),
          SizedBox(height: 10),
          Expanded(flex: 2, child: Container(color: Colors.red)),
          Expanded(child: Container(color: Colors.yellow)),
          Expanded(child: Container(color: Colors.green)),
        ],
      ),
    );
  }
}
