
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/single_user/single_user_controller/single_user_controller.dart';

final singleUserProvider=ChangeNotifierProvider<SingleUserController>((ref){
  return SingleUserController();
});
