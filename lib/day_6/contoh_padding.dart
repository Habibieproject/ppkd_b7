import 'package:flutter/material.dart';

class ContohPaddingDay6 extends StatelessWidget {
  const ContohPaddingDay6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 171, 64, 1),
        title: Text("Profil Saya"),
        centerTitle: true,
        actions: [Text("1"), Text("2")],
        leading: Icon(Icons.people),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        //mainAxisSize: MainAxisSize.Max,
        spacing: 20,
        children: [
          Padding(
            // padding: const EdgeInsets.all(24.0),
            // padding: const EdgeInsets.only(left: 24.0),
            padding: const EdgeInsets.symmetric(horizontal: 20),

            child: Text(
              "Seorang peserta pelatihan yang sedang mendalami Flutter di PPKD. "
              "Saya sangat antusias untuk belajar dan mengembangkan "
              "kemampuan saya dalam pengembangan aplikasi mobile. "
              "Flutter adalah framework yang sangat menarik "
              "karena memungkinkan pengembangan aplikasi lintas platform. "
              "Saya berharap dapat menguasai Flutter dengan baik "
              "dan menciptakan aplikasi yang bermanfaat. "
              "Selain itu, saya juga ingin berkontribusi "
              "dalam komunitas pengembang Flutter di masa depan.",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
