import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todotimer/app/home/presentation/home_controller.dart';
import 'package:todotimer/app/home/presentation/home_state_machine.dart';
import 'package:todotimer/app/home/presentation/view/widget/task_grid_widget.dart';
import 'package:todotimer/app/home/presentation/view/widget/task_list_widget.dart';
import 'package:todotimer/config/app-theme/app_theme.dart';
import 'package:todotimer/config/app-theme/core_app_theme.dart';
import 'package:todotimer/constants/db_keys.dart';
import 'package:todotimer/utils/enums.dart';
import 'package:todotimer/app/home/domain/entity/task_entity.dart';
import 'package:todotimer/utils/functions.dart';
import 'package:todotimer/utils/timer.dart';

class HomeInitializedView extends StatefulWidget {
  final HomeController controller;
  final HomeInitializiedState initializiedState;
  const HomeInitializedView(
      {required this.controller, required this.initializiedState, Key? key})
      : super(key: key);

  @override
  _HomeInitializedViewState createState() => _HomeInitializedViewState();
}

class _HomeInitializedViewState extends State<HomeInitializedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoreAppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: CoreAppTheme.largeSize,
                      top: CoreAppTheme.mediumSize,
                      left: CoreAppTheme.largeSize),
                  child: Text(
                    "Taskminder",
                    style: AppTheme.textStyleTitle
                        .copyWith(fontSize: CoreAppTheme.fontSizeExtraLarge),
                  ),
                ),
                Expanded(child: Container()),
                IconButton(
                  onPressed: () {
                    widget.controller.sharedPreferences
                                .getString(DBKeys.taskListViewKey) ==
                            describeEnum(TaskListView.LIST)
                        ? widget.controller
                            .changeView(taskListView: TaskListView.GRID)
                        : widget.controller
                            .changeView(taskListView: TaskListView.LIST);
                  },
                  icon: widget.controller.sharedPreferences
                              .getString(DBKeys.taskListViewKey) ==
                          describeEnum(TaskListView.LIST)
                      ? Icon(Icons.grid_3x3)
                      : Icon(Icons.list),
                )
              ],
            ),
            widget.controller.sharedPreferences
                        .getString(DBKeys.taskListViewKey) ==
                    describeEnum(TaskListView.LIST)
                ? TaskListWidget(
                    controller: widget.controller,
                    initializiedState: widget.initializiedState,
                  )
                : TaskGridWidget(
                    controller: widget.controller,
                    initializiedState: widget.initializiedState,
                  )
          ],
        )),
      ),
      floatingActionButton: MaterialButton(
        onPressed: () {
          addTask(context);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: AppTheme.boxDecorationListTile
              .copyWith(color: CoreAppTheme.primaryColor),
          width: 100,
          child: Text(
            "+ Task",
            style: AppTheme.textStyleNormal
                .copyWith(color: CoreAppTheme.backgroundColor),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                          SizedBox(height: 60),
                          Text('Title'),
                          TextFormField(
                            controller: titleTextController,
                          ),
                          Text('Description'),
                          TextFormField(
                            controller: descriptionTextController,
                            minLines: 3,
                            maxLines: 5,
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
                              if (durationTextController.text.isNotEmpty) {
                                if (dropdownValue == 0) {
                                  if (double.parse(
                                              durationTextController.text) <
                                          1 ||
                                      double.parse(
                                              durationTextController.text) >
                                          10) {
                                    Fluttertoast.showToast(
                                      msg:
                                          "   Invalid Duration!  Valid range is 1 to 10 minutes ",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                    );
                                    return;
                                  }
                                } else {
                                  if (double.parse(
                                              durationTextController.text) <
                                          1 ||
                                      double.parse(
                                              durationTextController.text) >
                                          10 * 60) {
                                    Fluttertoast.showToast(
                                      msg:
                                          " Invalid Duration!  Valid range is 1 to 600 seconds ",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                    );
                                    return;
                                  }
                                }
                              }
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
                                      "  Title and Duration fields are compulsory  ",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
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
