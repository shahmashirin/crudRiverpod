import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudriverpod/features/home_page/screens/undeleted_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/utils.dart';
import '../../../models/userdata_model.dart';
import '../../update_page/screens/edit_users.dart';
import 'add_user.dart';
import '../controller/home_screen_controller.dart';
import 'deleted_user.dart';

class ViewUser extends StatefulWidget {
  const ViewUser({Key? key});

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text("Details",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.deepPurple))),
          actions: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return UndeletedViews();
                        },
                      ));
                    },
                    icon: Column(
                      children: [
                        Icon(
                          Icons.delete_forever,
                          color: Colors.green,
                        ),
                      ],
                    )),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return DeletedViews();
                      },
                    ));
                  },
                  icon: Icon(Icons.delete, color: Colors.redAccent.shade100),
                ),
              ],
            )
          ],
          toolbarHeight: 40,
          bottom: TabBar(tabs: [Text("Users"), Text("New User")]),
          automaticallyImplyLeading: false,
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
                child: Consumer(builder: (context, ref, child) {
              var data = ref.watch(getHomeScreenProvider(''));
              return data.when(data: (data) {
                return Column(
                  children: [
                    SizedBox(
                      height: 650,
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          UserData snap = data[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 20, left: 20),
                            child: Card(
                              shadowColor: Colors.deepPurple.shade600,
                              // decoration: BoxDecoration(
                              //     color: Colors.grey.shade200,
                              //     borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Name:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(snap.name ?? ""),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Age:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(snap.age.toString() ?? "N/A"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Phone:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(snap.phone ?? ""),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextButton(
                                          onPressed: () async {
                                            // print('snap.uid');
                                            // print(snap.uid);
                                            bool prd = await alert(context,
                                                'Do you want to proceed');

                                            if (prd) {
                                              // print('object');
                                              FirebaseFirestore.instance
                                                  .collection('list')
                                                  .doc(snap.uid)
                                                  .update({'delete': true});
                                              // print('id');
                                              // print(snap.uid);
                                            }
                                          },
                                          child: Text("Delete",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditUser(
                                                          UserDataobj: snap),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "Edit",
                                              style: TextStyle(
                                                  color: Colors.deepPurple,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }, error: (error, stackTrace) {
                return Column(
                  children: [
                    Center(
                      child: Text(error.toString()),
                    )
                  ],
                );
              }, loading: () {
                return Center(
                  child: CircularProgressIndicator(),
                );
              });
            })),
            AddUser(),
          ],
        ),
      ),
    );
  }
}
