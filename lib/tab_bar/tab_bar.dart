import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/all_users/all_users_view/all_users_view.dart';
import 'package:task/register/register_page/register_page.dart';
import 'package:task/secure_storage/secure_storage.dart';
import 'package:task/single_user/single_user_riverpod/single_user_riverpod.dart';
import 'package:task/tab_home_screen/tab_home_screen.dart';

class TabBarPage extends ConsumerStatefulWidget {
  const TabBarPage({super.key});

  @override
  TabBarPageState createState() => TabBarPageState();
}

class TabBarPageState extends ConsumerState<TabBarPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(singleUserProvider).getUserId();
    print("hi flutter");
    print("hi hruthik");
  }

  @override
  Widget build(BuildContext context) {
    final singleUserListNer=ref.watch(singleUserProvider);
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(decoration:const BoxDecoration(color: Colors.blue),accountName:Text(singleUserListNer!.name.toString()), accountEmail: Text(singleUserListNer!.userId.toString())),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                onTap: () {
                    SecureStorage secure=SecureStorage();
                    secure.secureDelete("id");
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>RegisterPage()),(Route<dynamic> route) => false,);
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title:const TextField(
            decoration:InputDecoration(hintText: "Search"),
          ),
          actions:const [
            Icon(Icons.tune),
          ],
          backgroundColor: Colors.white,
          bottom:const TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.black,
            labelColor: Colors.blue,
            tabs: [
              Tab(
                child: Text(
                  "Home",
                ),
              ),
              Tab(
                child: Text(
                  "All",
                ),
              ),
              Tab(
                child: Text(
                  "People",
                ),
              ),
              Tab(
                child: Text(
                  "Groups",
                ),
              ),
              Tab(
                child: Text(
                  "Events",
                ),
              ),
              Tab(child: Text("Photos",),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TabHomeScreen(),
            Center(child: Text("All")),
            AllUsersView(),
            Center(child: Text("Groups")),
            Center(child: Text("Events")),
            Center(child: Text("Photos")),
          ],
        ),
      ),
    );
  }
}
