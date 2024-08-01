import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/all_users/riverpod/riverpod.dart';

class AllUsersView extends ConsumerStatefulWidget {
  const AllUsersView({super.key});

  @override
  AllUsersViewState createState() => AllUsersViewState();
}

class AllUsersViewState extends ConsumerState<AllUsersView> {
  @override
  void initState() {
    super.initState();
    ref.read(allUserProvider).getUsers(1);
  }

  Future users() async {
    ref.read(allUserProvider).getUsers(ref.read(allUserProvider).pageNumber);
  }

  @override
  Widget build(BuildContext context) {
    final userListNer = ref.watch(allUserProvider);
    return Scaffold(
      body: userListNer.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
            onRefresh: users,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  userListNer.count == 0
                      ? const Text("No Records Available")
                      : ListView.separated(
                          physics:const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: userListNer.count,
                          itemBuilder: (BuildContext context, index) {
                            final rec = userListNer.myList[index];
                            return Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                CircleAvatar(
                                  radius: 35,
                                  backgroundImage: NetworkImage(rec.avatar),
                                ),
                                const SizedBox(
                                  width: 35,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(rec.firstName),
                                    Text(rec.email),
                                    SizedBox(
                                      width: 265,
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1))),
                                          child: const Text(
                                            "Add Friend",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                          separatorBuilder:
                              (BuildContext context, int index) {
                            return const Divider(
                              thickness: 2,
                              color: Colors.grey,
                            );
                          },
                        ),
                  const Divider(thickness: 2,color: Colors.grey,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      myButton(() {
                        if (userListNer.count == 0) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("You are in the Last Page"),
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          userListNer.getUsers(++userListNer.pageNumber);
                        }
                      }, "Next Page -->"),
                      myButton(() {
                        if (userListNer.pageNumber == 1) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("You are in the First Page"),
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          userListNer.getUsers(--userListNer.pageNumber);
                        }
                      }, "<-- Previous Page"),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
    // });
  }

  myButton(operation, text) {
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
