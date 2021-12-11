import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'package:todotimer/app/home/presentation/home_controller.dart';
import 'package:todotimer/app/home/presentation/home_state_machine.dart';
import 'package:todotimer/app/home/presentation/view/initialized_state.dart';
import 'package:todotimer/widgets/error_view.dart';
import 'package:todotimer/widgets/loading_view.dart';

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
            controller.getTaks();
            return LoadingState();

          case HomeErrorState:
            return ErrorState();

          case HomeInitializiedState:
            return HomeInitializedView(
              controller: controller,
              initializiedState:
                  controller.getCurrentState() as HomeInitializiedState,
            );
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
