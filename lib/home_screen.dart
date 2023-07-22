import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudoku_solver/number_pad.dart';
import 'package:sudoku_solver/sudoku_controller.dart';
import 'package:sudoku_solver/sudoku_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sudoku solver',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        actions: [
          GetBuilder<SudokuController>(builder: (controller) {
            return IconButton(
                onPressed: () => controller.resetPuzzle(),
                tooltip: 'Reset Board',
                icon: const Icon(
                  Icons.restore_outlined,
                  color: Colors.white,
                ));
          })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: const SudokuGridView()),
            const NumberPad(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () => Get.put(SudokuController()).solvePuzzle(),
        child: const Icon(
          Icons.lightbulb,
          color: Colors.white,
        ),
      ),
    );
  }
}
