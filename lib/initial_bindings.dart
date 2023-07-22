import 'package:get/instance_manager.dart';
import 'package:sudoku_solver/sudoku_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SudokuController());
  }
}
