import 'package:todotimer/core/state_machine.dart';

class HomeStateMachine extends StateMachine<HomeState, HomeEvent> {
  HomeStateMachine() : super(HomeInitializationState());

  @override
  HomeState getStateOnEvent(HomeEvent event) {
    final eventType = event.runtimeType;
    HomeState newState = getCurrentState();
    switch (eventType) {
      case HomeInitializiedEvent:
        newState = new HomeInitializiedState();
    }
    return newState;
  }
}

class HomeState {}

class HomeInitializationState extends HomeState {}

class HomeInitializiedState extends HomeState {}

class HomeEvent {}

class HomeInitializiedEvent extends HomeEvent {}
