import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class UseCaseObserver implements Observer<dynamic> {
  final Function _onComplete;
  final Function _onError;
  final Function? onNextFunc;

  UseCaseObserver(this._onComplete, this._onError, {this.onNextFunc});

  @override
  void onComplete() {
    _onComplete();
  }

  @override
  void onError(error) {
    _onError(error);
  }

  @override
  void onNext(_) {
    if (onNextFunc != null) onNextFunc!(_);
  }
}
