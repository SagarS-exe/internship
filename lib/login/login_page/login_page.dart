import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task/login/login_model/login_model.dart';
import 'package:task/secure_storage/secure_storage.dart';
import 'package:task/tab_bar/tab_bar.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  User? userList;

  checkData(username, password, context) async
  {
    final url = Uri.parse("http://192.168.29.135:8080/chkId");
    final api = await http.post(
        url,
        headers: {
        "Content-Type": "application/json"
        },
        body: jsonEncode({
          "username": username,
          "password": password})
    );

    final decodeData = jsonDecode(api.body);
    final loginData = LoginUserData.fromJson(decodeData);
    userList=loginData.user;

    if (api.statusCode == 200 && loginData.message == "Correct Password")
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(loginData.message),
        duration: const Duration(seconds: 2),
      ));
      SecureStorage secureStorage=SecureStorage();
      secureStorage.secureWrite("id", userList!.id.toString());
      //print("43 -------${userList!.id}");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const TabBarPage()));
    }
    else
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(loginData.message),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login Page",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
                height: 200,
                child: Image.network("https://as2.ftcdn.net/v2/jpg/00/24/94/01/1000_F_24940114_byTrVVviV4zCscBU3F3uFzfY9j7CoPjG.jpg")),
            myLoginTextField(userNameController, "UserName"),
            myLoginTextField(passwordController, "Password"),
            myLoginButton(() {
              checkData(
                  userNameController.text, passwordController.text, context);
            }, "Login")
          ],
        ),
      ),
    );
  }

  myLoginTextField(controller, hintText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: hintText),
      ),
    );
  }

  myLoginButton(operation, text) {
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
