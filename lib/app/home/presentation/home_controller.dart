import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:todotimer/config/navigation_service.dart';
import 'package:todotimer/core/injection_container.dart';
import 'package:todotimer/core/observer.dart';
import 'package:todotimer/app/home/domain/entity/task_entity.dart';
import 'package:todotimer/app/home/presentation/home_presenter.dart';
import 'package:todotimer/app/home/presentation/home_state_machine.dart';

class HomeController extends Controller {
  final HomePresenter _presenter;
  final HomeStateMachine _stateMachine;
  final NavigationService _navigationService;
  HomeController()
      : _presenter = serviceLocator<HomePresenter>(),
        _stateMachine = new HomeStateMachine(),
        _navigationService = serviceLocator<NavigationService>(),
        super();

  @override
  void initListeners() {}

  @override
  void onInitState() {
    super.onInitState();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  HomeState getCurrentState() {
    return _stateMachine.getCurrentState();
  }

  void getTasks() {
    // _presenter.getTasks(
    //   new UseCaseObserver(
    //     () {},
    //     (error) {
    //       print("HomeController : getTasks : $error");
    //     },
    //     onNextFunc: (List<TaskEntity> tasks) {
    //       print(tasks);
          _stateMachine.onEvent(new HomeInitializiedEvent());
          refreshUI();
    //     },
    //   ),
    // );
  }

  void createTask({required TaskEntity task}) {
    _presenter.createTask(
        new UseCaseObserver(
          () {},
          (error) {
            print("HomeController : createTask : $error");
          },
        ),
        task: task);
  }
}
