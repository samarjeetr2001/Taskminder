import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todotimer/app/home/presentation/home_controller.dart';
import 'package:todotimer/core/database/boxes/boxes.dart';
import 'package:todotimer/core/database/models/task.dart';
import 'package:todotimer/utils/enums.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todotimer/app/home/domain/entity/task_entity.dart';
import 'package:todotimer/utils/functions.dart';
import 'package:todotimer/utils/timer.dart';

class HomeInitializedView extends StatefulWidget {
  final HomeController controller;
  const HomeInitializedView({required this.controller, Key? key})
      : super(key: key);

  @override
  _HomeInitializedViewState createState() => _HomeInitializedViewState();
}

class _HomeInitializedViewState extends State<HomeInitializedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.grid_3x3))],
      ),
      body: ValueListenableBuilder<Box<Task>>(
        valueListenable: Boxes.getTaskBox().listenable(),
        builder: (context, box, _) {
          final tasks = box.values.toList().cast<Task>();
          return SingleChildScrollView(
            child: Column(
              children: [
                for (var i = 0; i < tasks.length; i++)
                  ListTile(
                    title: Text(tasks[i].title),
                    subtitle: Row(
                      children: [
                        Text(
                          tasks[i].status.toString(),
                        ),
                        if (TaskTimer.timer[tasks[i].id] == null ||
                            !TaskTimer.timer[tasks[i].id]!.isActive)
                          MaterialButton(
                            onPressed: () {
                              TaskTimer timer = new TaskTimer(
                                id: tasks[i].id,
                                duration: tasks[i].durationInSec.round(),
                              );
                              timer.startTimer(
                                onComplete: () {
                                  widget.controller.updateStatus(
                                      id: tasks[i].id, status: Status.DONE);
                                },
                                periodicFunction: () {
                                  widget.controller.updateTime(
                                      id: tasks[i].id,
                                      durationInSec: timer.duration.toDouble());
                                },
                              );
                              widget.controller.updateStatus(
                                  id: tasks[i].id, status: Status.IN_PROGRESS);
                            },
                            child: Text(TaskTimer.timer[tasks[i].id] == null
                                ? "Start"
                                : tasks[i].durationInSec == 0
                                    ? "Completed"
                                    : "Resume"),
                          ),
                        if (TaskTimer.timer[tasks[i].id] != null)
                          if (TaskTimer.timer[tasks[i].id]!.isActive)
                            MaterialButton(
                              onPressed: () {
                                TaskTimer.timer[tasks[i].id]!.cancel();
                                widget.controller.updateStatus(
                                    id: tasks[i].id, status: Status.ON_HOLD);
                                setState(() {});
                              },
                              child: Text("Pause"),
                            )
                      ],
                    ),
                    leading: Text(tasks[i].id),
                    trailing: Text(tasks[i].durationInSec.toString()),
                  )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTask(context);
        },
      ),
    );
  }

  void addTask(BuildContext context) {
    int dropdownValue = 0;
    final TextEditingController titleTextController =
        new TextEditingController();
    final TextEditingController descriptionTextController =
        new TextEditingController();
    final TextEditingController durationTextController =
        new TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateModal) {
            return Container(
                height: 450,
                child: Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("New Task"),
                          SizedBox(height: 80),
                          Text('Title'),
                          TextFormField(
                            controller: titleTextController,
                          ),
                          Text('Description'),
                          TextFormField(
                            controller: descriptionTextController,
                          ),
                          Text('Duration'),
                          Row(
                            children: [
                              Expanded(
                                  child: TextFormField(
                                controller: durationTextController,
                                keyboardType: TextInputType.number,
                              )),
                              DropdownButton<int>(
                                underline: SizedBox(),
                                value: dropdownValue,
                                items: <int>[0, 1].map((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(
                                        value == 0 ? 'minutes' : 'seconds'),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    dropdownValue = value!;
                                  });
                                },
                              )
                            ],
                          ),
                          SizedBox(height: 50),
                          MaterialButton(
                            color: Colors.blue,
                            onPressed: () {
                              if (titleTextController.text.isNotEmpty &&
                                  durationTextController.text.isNotEmpty) {
                                widget.controller.createTask(
                                  task: new TaskEntity(
                                    id: getRandomString(11),
                                    title: titleTextController.text,
                                    description: descriptionTextController.text,
                                    createdDate: DateTime.now(),
                                    status: Status.TODO,
                                    durationInSec: double.parse(
                                      dropdownValue == 0
                                          ? (double.parse(durationTextController
                                                      .text) *
                                                  60)
                                              .toString()
                                          : durationTextController.text,
                                    ),
                                  ),
                                );
                                Navigator.pop(context);
                              } else {
                                Fluttertoast.showToast(
                                  msg:
                                      "     Title & Duration fields are compulsory     ",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                );
                              }
                            },
                            child: Text("Add"),
                          )
                        ],
                      ),
                    ),
                  ),
                ));
          },
        );
      },
    );
  }
}
