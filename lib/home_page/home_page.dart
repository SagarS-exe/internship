import 'package:flutter/material.dart';
import 'package:task/register/register_page/register_page.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "All Users App",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 300,
              height: 300,
              child: Image(image: AssetImage("Images/images.jpeg"),),
            ),
            myHomeButton(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterPage()));
            }, "Register")
          ],
        ),
      ),
    );
  }

  myHomeButton(operation, text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: operation,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
}
