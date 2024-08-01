import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:task/secure_storage/secure_storage.dart';
import 'package:task/single_user/single_user_model/single_user_model.dart';

class SingleUserController extends ChangeNotifier
{
  String name="";
  String userId="";
  String? id;

  User? myUser;
  getUserId()async
  {
    SecureStorage secureStorage=SecureStorage();
    id=await secureStorage.secureRead("id");

    notifyListeners();
    //print("19 --------$id");

    final url=Uri.parse("http://192.168.29.135:8080/getSingleUser/$id");

    final api=await http.get(
        url,
        headers: {
          "Content-Type":"application/json",
        }
    );

    //print(api.body);

    final decodeData=jsonDecode(api.body);
    final singleUser=SingleUserData.fromJson(decodeData);

    myUser=singleUser.user;
    //print(myUser);

    if(api.statusCode==200 && singleUser.message=="Account Found")
    {
      name=myUser!.name;
      userId=myUser!.username;
      notifyListeners();
    }
    else
    {
      if (kDebugMode) {
        print(singleUser.message);
      }
    }

  }
}
