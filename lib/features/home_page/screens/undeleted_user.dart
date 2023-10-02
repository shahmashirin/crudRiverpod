import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/userdata_model.dart';
import '../../home_page/controller/home_screen_controller.dart';

class UndeletedViews extends StatefulWidget {
  const UndeletedViews({Key? key});

  @override
  State<UndeletedViews> createState() => _UndeletedViewsState();
}

class _UndeletedViewsState extends State<UndeletedViews> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Undeleted user",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body:
          SingleChildScrollView(child: Consumer(builder: (context, ref, child) {
        var data = ref.watch(getUndeteteduserProvider(''));
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
                      padding:
                          const EdgeInsets.only(top: 10, right: 20, left: 20),
                      child: Card(shadowColor: Colors.deepPurple.shade600,
                        // decoration: BoxDecoration(
                        //     color: Colors.grey.shade200,
                        //     borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  Text(snap.age.toString() ?? ""),
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
    );
  }
}
