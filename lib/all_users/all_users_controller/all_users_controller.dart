import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:task/all_users/all_users_model/all_users_model.dart';

class AllUsersController extends ChangeNotifier {
  bool isLoading = false;
  int pageNumber = 0;
  int count = 0;

  List<Datum> myList = [];

  // AllUsersController()
  // {
  //     getUsers(1);
  // }

  getUsers(page) async {
    final url = Uri.parse("https://reqres.in/api/users?page=$page");
    final api = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    isLoading = true;
    notifyListeners();

    if (api.statusCode == 200) {
      final decodeData = jsonDecode(api.body);
      final userData = AllUsersData.fromJson(decodeData);

      myList = userData.data;
      pageNumber = userData.page;
      count = userData.data.length;
      isLoading = false;
      notifyListeners();
    } else {
      if (kDebugMode) {
        print("Error");
        print(api.statusCode);
      }
    }
  }
}
