import 'package:flutter/foundation.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotimer/config/navigation_service.dart';
import 'package:todotimer/constants/db_keys.dart';
import 'package:todotimer/core/injection_container.dart';
import 'package:todotimer/core/observer.dart';
import 'package:todotimer/app/home/domain/entity/task_entity.dart';
import 'package:todotimer/app/home/presentation/home_presenter.dart';
import 'package:todotimer/app/home/presentation/home_state_machine.dart';
import 'package:todotimer/utils/enums.dart';

class HomeController extends Controller {
  final HomePresenter _presenter;
  final HomeStateMachine _stateMachine;
  final NavigationService _navigationService;
  late SharedPreferences sharedPreferences;

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

  void getTaks() async {
    sharedPreferences = await SharedPreferences.getInstance();
    _presenter.getTasks(
      new UseCaseObserver(() {}, (error) {
        print("HomeController : getTaks : $error");
        _stateMachine.onEvent(new HomeErrorEvent());
        refreshUI();
      }, onNextFunc: (List<TaskEntity> tasks) {
        tasks.sort((a, b) => (b.createdDate.compareTo(a.createdDate)));

        _stateMachine.onEvent(new HomeInitializiedEvent(tasks: tasks));
        refreshUI();
      }),
    );
  }

  void updateTime({required String id, required double durationInSec}) {
    _presenter.updateTaskTimer(
        new UseCaseObserver(() {}, (error) {
          print("HomeController : updateTime : $error");
          _stateMachine.onEvent(new HomeErrorEvent());
          refreshUI();
        }),
        id: id,
        durationInSec: durationInSec);
  }

  void updateStatus({required String id, required Status status}) {
    _presenter.updateTaskStatus(
        new UseCaseObserver(() {}, (error) {
          print("HomeController : updateStatus : $error");
          _stateMachine.onEvent(new HomeErrorEvent());
          refreshUI();
        }),
        id: id,
        status: status);
  }

  void createTask({required TaskEntity task}) {
    _presenter.createTask(
        new UseCaseObserver(
          () {},
          (error) {
            print("HomeController : createTask : $error");
            _stateMachine.onEvent(new HomeErrorEvent());
            refreshUI();
          },
        ),
        task: task);
  }

  void changeView({required TaskListView taskListView}) async {
    await sharedPreferences.setString(
        DBKeys.taskListViewKey, describeEnum(taskListView));
    refreshUI();
  }
}
