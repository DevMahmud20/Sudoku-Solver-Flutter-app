import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class SudokuController extends GetxController {
  List<List<int>> sudokuBoard = List.generate(9, (_) => List.filled(9, 0));
  int selectedCellIndex = -1;
  bool isPuzzleSolved = false;

  void resetPuzzle() {
    selectedCellIndex = -1;
    isPuzzleSolved = false;
    sudokuBoard = List.generate(9, (_) => List.filled(9, 0));
    update();
  }

  updateSelectedCellIndex(int index) {
    if (isPuzzleSolved) {
      return true;
    }
    selectedCellIndex = index;
    update();
  }

  updateCellValue(int index, int value) {
    int row = selectedCellIndex ~/ 9;
    int col = selectedCellIndex % 9;
    //validate the input value before updating the board
    if (isValidMove(row, col, value)) {
      if (value != 11) {
        sudokuBoard[row][col] = value;
      } else {
        sudokuBoard[row][col] = 0;
      }
      update();
    } else {
      showErrorDialog('Invalid input');
    }
  }

  showErrorDialog(String message) {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text('Error!'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }


  void solvePuzzle() {
    if (_solveSudoku()) {
      //isPuzzleSolved = true;
      selectedCellIndex = -1;
      
      update();
    } else {
      // Puzzle is not solvable
      showErrorDialog('The Sudoku puzzle is not solvable.');
    }
  }

  bool _solveSudoku() {
    int emptyCellIndex = findEmptyCell();
    if (emptyCellIndex == -1) {
      // If there are no empty cells, the puzzle is solved
      isPuzzleSolved = true;
      update();
      return true;
    }

    int row = emptyCellIndex ~/ 9;
    int col = emptyCellIndex % 9;

    for (int num = 1; num <= 9; num++) {
      if (isValidMove(row, col, num)) {
        // If the current number is a valid move, place it in the cell
        sudokuBoard[row][col] = num;

        if (_solveSudoku()) {
          // Recursively solve the rest of the puzzle
          return true;
        }
        // If placing the current number doesn't lead to a solution, backtrack
        sudokuBoard[row][col] = 0;
      }
    }
    // If no number from 1 to 9 leads to a solution, backtrack to previous cell
    update();
    return false;
  }

  int findEmptyCell() {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (sudokuBoard[i][j] == 0) {
          return i * 9 + j;
        }
      }
    }
    return -1;
  }

  // Function to check if placing a number in a cell is valid
  bool isValidMove(int row, int col, int num) {
    // Check the row
    for (int i = 0; i < 9; i++) {
      if (sudokuBoard[row][i] == num) {
        return false;
      }
    }

    // Check the column
    for (int i = 0; i < 9; i++) {
      if (sudokuBoard[i][col] == num) {
        return false;
      }
    }

    // Check the 3x3 box
    int boxRowStart = (row ~/ 3) * 3;
    int boxColStart = (col ~/ 3) * 3;
    for (int i = boxRowStart; i < boxRowStart + 3; i++) {
      for (int j = boxColStart; j < boxColStart + 3; j++) {
        if (sudokuBoard[i][j] == num) {
          return false;
        }
      }
    }

    return true; // If the number doesn't violate any rule, it's a valid move
  }
}
