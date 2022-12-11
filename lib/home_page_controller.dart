import 'package:mobx/mobx.dart';
import 'package:mobx_example/home_states.dart';

part 'home_page_controller.g.dart';

class HomeController extends _HomeController with _$HomeController {}

abstract class _HomeController with Store {
  @observable
  HomeState state = HomeInitialState();
  @action
  void updateState(HomeState newState) {
    state = newState;
  }

  @observable
  int counter = 0;
  @action
  Future<void> incrementCounter() async {
    try {
      updateState(HomeLoadingState());
      await Future.delayed(const Duration(
          seconds: 10)); // aqui colocamos uma chamada na API no lugar do delay
      counter++;
      updateState(HomeSuccessState());
    } catch (e) {
      updateState(HomeErrorState());
    }
  }
}

//o observable é o value
