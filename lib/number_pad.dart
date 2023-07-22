import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sudoku_solver/sudoku_controller.dart';

class NumberPad extends StatefulWidget {
  const NumberPad({super.key});

  @override
  State<NumberPad> createState() => _NumberPadState();
}

class _NumberPadState extends State<NumberPad> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      //height: 200,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1.5, // Force square aspect ratio
        ),
        itemCount: 12,
        itemBuilder: (BuildContext context, int index) {
          int number = index + 1;
          return buildNumberButton(number);
        },
      ),
    );
  }

  Widget buildNumberButton(int number) {
    if (number == 10 || number == 12) {
      return Container();
    }
    return GetBuilder<SudokuController>(builder: (controller) {
      return ElevatedButton(
        onPressed: () {
          if (controller.selectedCellIndex != -1) {
            controller.updateCellValue(controller.selectedCellIndex, number);
          }
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          minimumSize: const Size(40, 40),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: number < 10
              ? Text(
                  '$number',
                  style: const TextStyle(fontSize: 20),
                )
              : const Icon(Icons.backspace),
        ),
      );
    });
  }
}
