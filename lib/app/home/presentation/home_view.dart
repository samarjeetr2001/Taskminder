import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'package:todotimer/app/home/presentation/home_controller.dart';
import 'package:todotimer/app/home/presentation/home_state_machine.dart';
import 'package:todotimer/app/home/presentation/view/initialized_state.dart';

class HomeView extends View {
  @override
  State<StatefulWidget> createState() => HomeViewState();
}

class HomeViewState extends ResponsiveViewState<HomeView, HomeController> {
  HomeViewState() : super(new HomeController());

  @override
  Widget get desktopView => throw UnimplementedError();

  @override
  Widget get mobileView {
    return ControlledWidgetBuilder<HomeController>(
      builder: (context, controller) {
        final currentStateType = controller.getCurrentState().runtimeType;
        switch (currentStateType) {
          case HomeInitializationState:
            return HomeInitializedView(
              controller: controller,
            );
          case HomeInitializiedState:
            {
              controller.getTasks();
              return Scaffold(
                body: Center(
                  child: Text("Loading ...."),
                ),
              );
            }
        }
        throw Exception("Unrecognized state $currentStateType encountered");
      },
    );
  }

  @override
  Widget get tabletView => throw UnimplementedError();

  @override
  Widget get watchView => throw UnimplementedError();
}
