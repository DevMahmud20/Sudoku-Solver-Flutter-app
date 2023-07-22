import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudoku_solver/sudoku_controller.dart';

class SudokuGridView extends StatefulWidget {
  const SudokuGridView({super.key});

  @override
  State<SudokuGridView> createState() => _SudokuGridViewState();
}

class _SudokuGridViewState extends State<SudokuGridView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SudokuController>(builder: (controller) {
      return GridView.builder(
        shrinkWrap: false,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 9,
        ),
        itemCount: 81, // 9x9 cells
        itemBuilder: (BuildContext context, int index) {
          int row = index ~/ 9; // Integer division to get the row number
          int col = index % 9; // Modulus to get the column number
          bool isSelected = controller.selectedCellIndex == index;
          return buildSudokuCell(row, col, isSelected);
        },
      );
    });
  }

  Widget buildSudokuCell(int row, int col, bool isSelected) {
    // Calculate the box index for each cell
    int boxIndex = (row ~/ 3) * 3 + col ~/ 3;
    // Determine the background color based on the box index
    Color boxColor = boxIndex % 2 == 0 ? Colors.grey[200]! : Colors.grey[500]!;
    Color cellColor = isSelected ? Colors.green : boxColor;

    // Customize the appearance of each cell as needed
    return GetBuilder<SudokuController>(builder: (controller) {
      return GestureDetector(
        onTap: () => controller.updateSelectedCellIndex(row * 9 + col),
        child: Container(
          decoration: BoxDecoration(
            color: cellColor,
            border: Border.all(color: Colors.black),
          ),
          child: Center(
            child: Text(
              // selectedCellIndex == row * 9 + col
              //     ? selectedNumber == -1
              //         ? ''
              //         : '$selectedNumber'
              //     : '',

              controller.sudokuBoard[row][col] != 0
                  ? controller.sudokuBoard[row][col].toString()
                  : '',
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      );
    });
  }
}
