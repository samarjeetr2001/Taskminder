import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todotimer/app/home/domain/entity/task_entity.dart';
import 'package:todotimer/app/home/presentation/home_controller.dart';
import 'package:todotimer/app/home/presentation/home_state_machine.dart';
import 'package:todotimer/config/app-theme/app_theme.dart';
import 'package:todotimer/config/app-theme/core_app_theme.dart';
import 'package:todotimer/utils/enums.dart';
import 'package:todotimer/utils/timer.dart';

class TaskListWidget extends StatefulWidget {
  final HomeController controller;
  final HomeInitializiedState initializiedState;
  const TaskListWidget(
      {required this.controller, required this.initializiedState, Key? key})
      : super(key: key);

  @override
  _TaskListWidgetState createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (TaskEntity task in widget.initializiedState.tasks)
            Container(
              margin: EdgeInsets.all(CoreAppTheme.smallSize),
              padding: EdgeInsets.only(left: CoreAppTheme.smallSize),
              decoration: AppTheme.boxDecorationListTile.copyWith(
                color: task.status == Status.TODO
                    ? CoreAppTheme.redShadeColor
                    : task.status == Status.IN_PROGRESS
                        ? CoreAppTheme.primaryColor
                        : task.status == Status.DONE
                            ? CoreAppTheme.greenShadeColor
                            : CoreAppTheme.secondaryColor,
              ),
              child: Container(
                decoration:
                    AppTheme.boxDecorationListTile.copyWith(boxShadow: []),
                child: ExpansionTile(
                  children: [
                    if (task.description != null && task.description != "")
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          task.description!,
                          style: AppTheme.textStyleNormal
                              .copyWith(fontSize: CoreAppTheme.fontSizeSmall),
                        ),
                      )
                  ],
                  title: Text(
                    task.title,
                    style: AppTheme.textStyleTitle,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        if (task.status == Status.IN_PROGRESS)
                          Text(
                            "you can do it :  ",
                            style: AppTheme.textStyleNormal
                                .copyWith(fontSize: CoreAppTheme.fontSizeSmall),
                          ),
                        if (task.status == Status.ON_HOLD)
                          Text(
                            "resume your task :  ",
                            style: AppTheme.textStyleNormal
                                .copyWith(fontSize: CoreAppTheme.fontSizeSmall),
                          ),
                        if (task.status == Status.TODO)
                          Text(
                            "start working on it :  ",
                            style: AppTheme.textStyleNormal
                                .copyWith(fontSize: CoreAppTheme.fontSizeSmall),
                          ),
                        Container(
                          child: Text(
                            task.durationInSec == 0
                                ? "Completed"
                                : "${(task.durationInSec ~/ 60)}m ${(task.durationInSec % 60).toInt()}s",
                            style: AppTheme.textStyleSubtitle.copyWith(
                                color: CoreAppTheme.primaryColor,
                                fontSize: CoreAppTheme.fontSizeSmall),
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: task.status != Status.DONE
                      ? Switch(
                          activeColor: CoreAppTheme.primaryColor,
                          value: task.status == Status.IN_PROGRESS &&
                                  TaskTimer.timer[task.id] != null
                              ? true
                              : false,
                          onChanged: (value) {
                            print(value);
                            if (value) {
                              startTimer(task);
                            } else {
                              stopTimer(task);
                            }
                          })
                      : SizedBox(),
                  //Text(task.durationInSec.toString()),
                ),
              ),
            )
        ],
      ),
    );
  }

  void stopTimer(TaskEntity task) {
    TaskTimer.timer[task.id]!.cancel();
    widget.controller.updateStatus(id: task.id, status: Status.ON_HOLD);
    setState(() {});
  }

  void startTimer(TaskEntity task) {
    TaskTimer timer = new TaskTimer(
      id: task.id,
      duration: task.durationInSec.round(),
    );
    timer.startTimer(
      onComplete: () {
        widget.controller.updateStatus(id: task.id, status: Status.DONE);
      },
      periodicFunction: () {
        widget.controller
            .updateTime(id: task.id, durationInSec: timer.duration.toDouble());
      },
    );
    widget.controller.updateStatus(id: task.id, status: Status.IN_PROGRESS);
  }
}
