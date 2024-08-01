
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/all_users/all_users_controller/all_users_controller.dart';

final allUserProvider=ChangeNotifierProvider<AllUsersController>((ref){
  return AllUsersController();
});
