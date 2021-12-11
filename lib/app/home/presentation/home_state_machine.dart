import 'package:todotimer/app/home/domain/entity/task_entity.dart';
import 'package:todotimer/core/state_machine.dart';

class HomeStateMachine extends StateMachine<HomeState, HomeEvent> {
  HomeStateMachine() : super(HomeInitializationState());

  @override
  HomeState getStateOnEvent(HomeEvent event) {
    final eventType = event.runtimeType;
    HomeState newState = getCurrentState();
    switch (eventType) {
      case HomeInitializiedEvent:
        HomeInitializiedEvent initializiedEvent =
            event as HomeInitializiedEvent;
        newState = new HomeInitializiedState(tasks: initializiedEvent.tasks);
        break;
      case HomeErrorEvent:
        newState = new HomeErrorState();
    }
    return newState;
  }
}

class HomeState {}

class HomeInitializationState extends HomeState {}

class HomeErrorState extends HomeState {}

class HomeInitializiedState extends HomeState {
  final List<TaskEntity> tasks;

  HomeInitializiedState({required this.tasks});
}

class HomeEvent {}

class HomeInitializiedEvent extends HomeEvent {
  final List<TaskEntity> tasks;

  HomeInitializiedEvent({required this.tasks});
}

class HomeErrorEvent extends HomeEvent {}
