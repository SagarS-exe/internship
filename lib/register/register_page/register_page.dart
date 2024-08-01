import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task/home_page/home_page.dart';
import 'package:task/login/login_page/login_page.dart';
import 'package:task/register/register_model/register_model.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController nameController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final TextEditingController userNameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  clearAll()
  {
    nameController.clear();
    ageController.clear();
    userNameController.clear();
    passwordController.clear();
  }

  addData(name, age, username, password, context) async {
    final url = Uri.parse("http://192.168.29.135:8080/addData");
    final api = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "age": int.parse(age),
          "username": username,
          "password": password
        }));

    final decodeData = jsonDecode(api.body);
    final registerData = RegisterUserData.fromJson(decodeData);

    if (api.statusCode == 200 && registerData.message == "Account Created Successfully")
    {
      clearAll();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(registerData.message),
        duration: const Duration(seconds: 2),
      ));
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    }
    else
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(registerData.message),
        duration: const Duration(seconds: 2),
      ));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Register Page",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            myTextField(nameController, "Name"),
            myTextField(ageController, "Age"),
            myTextField(userNameController, "UserName"),
            myTextField(passwordController, "Password"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                myRegisterButton(() {
                  addData(nameController.text, ageController.text,
                      userNameController.text, passwordController.text, context);
                }, "Register"),
                myRegisterButton((){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));
                }, "Go Back"),
              ],
            ),
            RichText(
                text: TextSpan(children: [
              const TextSpan(
                  text: "Already Have an Account? ",
                  style: TextStyle(color: Colors.black)),
              TextSpan(
                  text: "Login",
                  style: const TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }),
            ]))
          ],
        ),
      ),
    );
  }

  myTextField(controller, hintText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: hintText),
      ),
    );
  }

  myRegisterButton(operation, text) {
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
