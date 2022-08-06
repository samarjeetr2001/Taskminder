import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todotimer/app/home/presentation/home_controller.dart';
import 'package:todotimer/app/home/presentation/home_state_machine.dart';
import 'package:todotimer/widgets/empty_state.dart';
import 'package:todotimer/app/home/presentation/view/widget/task_grid_widget.dart';
import 'package:todotimer/app/home/presentation/view/widget/task_list_widget.dart';
import 'package:todotimer/config/app-theme/app_theme.dart';
import 'package:todotimer/config/app-theme/core_app_theme.dart';
import 'package:todotimer/constants/db_keys.dart';
import 'package:todotimer/utils/enums.dart';


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
      backgroundColor: widget.initializiedState.tasks.length == 0
          ? Color(0xffFBFBFB)
          : CoreAppTheme.backgroundColor,
      body: SingleChildScrollView(
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
            if (widget.initializiedState.tasks.length == 0)
              SizedBox(height: 100),
            if (widget.initializiedState.tasks.length == 0) EmptyState(),
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
        ),
      ),
    );
  }
}
