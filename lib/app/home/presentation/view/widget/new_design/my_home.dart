import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todotimer/app/home/domain/entity/task_entity.dart';
import 'package:todotimer/app/home/presentation/home_controller.dart';
import 'package:todotimer/app/home/presentation/home_state_machine.dart';
import 'package:todotimer/app/home/presentation/view/initialized_state.dart';
import 'package:todotimer/app/home/presentation/view/widget/new_design/task_success_widget.dart';
import 'package:todotimer/config/app-theme/core_app_theme.dart';
import 'package:todotimer/utils/enums.dart';
import 'package:todotimer/utils/functions.dart';
import 'package:todotimer/widgets/expand_collapse_widget.dart';

import 'add_new_task_collapse_widget.dart';
import 'add_new_task_view.dart';
import 'duration_widget.dart';
import 'initialized_collapse_widget.dart';

class MyHome extends StatefulWidget {
  MyHome({Key? key, required this.controller, required this.initializiedState})
      : super(key: key);
  final HomeController controller;
  final HomeInitializiedState initializiedState;

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final List<Widget> _child = [];
  var titleTextController = TextEditingController();
  var descriptionTextController = TextEditingController();
  int durationInSec = 300;
  final collapasedHeight = 100.0;

  @override
  Widget build(BuildContext context) {
    final expandedHeight =
        MediaQuery.of(context).size.height - CoreAppTheme.fontSizeExtraLarge;
    return Scaffold(
      backgroundColor: CoreAppTheme.backgroundColor,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: CoreAppTheme.fontSizeExtraLarge),
            ExpandCollapseWidget(
              expandedChild: HomeInitializedView(
                controller: widget.controller,
                initializiedState: widget.initializiedState,
              ),
              expandedHeight: expandedHeight,
              buttonText: '+ Task',
              onTap: () {
                _child.clear();
                titleTextController = TextEditingController();
                descriptionTextController = TextEditingController();
                _child.add(
                  ExpandCollapseWidget(
                    expandedChild: AddNewTaskView(
                      controller: widget.controller,
                      titleTextController: titleTextController,
                      descriptionTextController: descriptionTextController,
                    ),
                    expandedHeight: expandedHeight - collapasedHeight,
                    buttonText: 'Next >',
                    onTap: () {
                      durationInSec = 300;
                      _child.add(
                        ExpandCollapseWidget(
                          disabled: true,
                          expandedChild: durationWidget(
                            (double value) {
                              durationInSec = value.toInt();
                            },
                          ),
                          expandedHeight: expandedHeight - 2 * collapasedHeight,
                          buttonText: 'Submit',
                          onTap: () {
                            if (titleTextController.text.isNotEmpty) {
                              widget.controller.createTask(
                                task: TaskEntity(
                                  id: getRandomString(11),
                                  title: titleTextController.text,
                                  description: descriptionTextController.text,
                                  createdDate: DateTime.now(),
                                  status: Status.TODO,
                                  durationInSec:
                                      double.parse(durationInSec.toString()),
                                ),
                              );
                              setState(() {
                                _child.clear();
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => TaskSuccessWidget(),
                                  ),
                                );
                              });
                            } else {
                              Fluttertoast.showToast(
                                msg: "  Title field is compulsory  ",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                              );
                            }
                          },
                          collapsedChild: addNewTaskCollapseWidget(
                              titleTextController.text),
                          collapsedHeight: collapasedHeight,
                        ),
                      );
                      setState(() {});
                    },
                    collapsedChild:
                        addNewTaskCollapseWidget(titleTextController.text),
                    collapsedHeight: collapasedHeight,
                  ),
                );
                setState(() {});
              },
              collapsedChild: initializedCollapseWidget(
                widget.initializiedState.tasks.length,
              ),
              collapsedHeight: collapasedHeight,
            ),
            ..._child,
          ],
        ),
      ),
    );
  }
}
