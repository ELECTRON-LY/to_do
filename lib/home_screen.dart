import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/detailes_screen.dart';
import 'package:to_do_app/task_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController subtitlecontroller = TextEditingController();
  List<TaskModel> donetasks = [];
  List<TaskModel> notdonetasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: titlecontroller,
                                decoration: InputDecoration(
                                    hintText: 'enter text Title ....',
                                    hintStyle: TextStyle(
                                        color: Colors.green.withOpacity(0.5))),
                              ),
                              TextField(
                                controller: subtitlecontroller,
                                decoration: InputDecoration(
                                    hintText: 'enter text sub Title',
                                    hintStyle: TextStyle(
                                        color: Colors.green.withOpacity(0.5))),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  MaterialButton(
                                    onPressed: () {
                                      if (titlecontroller.text.isNotEmpty) {
                                        notdonetasks.add(TaskModel(
                                            title: titlecontroller.text,
                                            subTitle:
                                                subtitlecontroller.text.isEmpty
                                                    ? null
                                                    : subtitlecontroller.text,
                                            dt: DateTime.now()));
                                      }
                                      titlecontroller.clear();
                                      subtitlecontroller.clear();
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    color: Colors.green,
                                    child: Row(children: const [
                                      Text(
                                        'add',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ]),
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      titlecontroller.clear();
                                      subtitlecontroller.clear();
                                      Navigator.pop(context);
                                    },
                                    color: Colors.green,
                                    child: Row(children: const [
                                      Text(
                                        'cancel',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ]),
                                  )
                                ],
                              )
                            ],
                          )),
                    );
                  });
            }),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              // inkwell
              const TabBar(
                tabs: [
                  Tab(
                    text: 'done1',
                  ),
                  Tab(
                    text: 'waiting',
                  )
                ],
                labelColor: Colors.blue,
              ),
              Expanded(
                  child: TabBarView(children: [
                Center(
                    child: ListView.builder(
                        itemCount: donetasks.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => DetailesScreen(
                                            taskModel: donetasks[index])));
                              },
                              child: ListTile(
                                title: Text(donetasks[index].title),
                                subtitle: Text(donetasks[index]
                                    .dt
                                    .toString()
                                    .substring(0, 10)
                                    .replaceAll('-', '/')),
                                trailing: Checkbox(
                                  value: true,
                                  onChanged: (value) {
                                    setState(() {
                                      // donetasks[index].isDone =!donetasks[index].isDone;
                                      notdonetasks.add(donetasks[index]);
                                      donetasks.removeAt(index);
                                    });
                                  },
                                ),
                              ));
                        })),
                Center(
                    child: ListView.builder(
                        itemCount: notdonetasks.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => DetailesScreen(
                                            taskModel: notdonetasks[index])));
                              },
                              child: ListTile(
                                title: Text(notdonetasks[index].title),
                                subtitle: Text(notdonetasks[index]
                                    .dt
                                    .toString()
                                    .substring(0, 10)
                                    .replaceAll('-', '/')),
                                trailing: Checkbox(
                                  value: false,
                                  onChanged: (value) {
                                    // notdonetasks[index].isDone =!notdonetasks[index].isDone;
                                    donetasks.add(notdonetasks[index]);
                                    notdonetasks.removeAt(index);

                                    setState(() {});
                                  },
                                ),
                              ));
                        })),
              ]))
            ],
          ),
        ));
  }
}
