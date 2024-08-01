import 'package:flutter/material.dart';

class TabHomeScreen extends StatelessWidget {
  const TabHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 300,
                  width: 300,
                  child: Image.asset("Images/homeimage.jpeg")),
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.blue,width: 5)),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Welcome To All Users App",),
                )),
          ],
        ),
      ),
    );
  }
}

