import 'dart:io';
import 'dart:math';

void main() {
  /// Make the User select the Mark
  bool acceptedMarker = false;
  String? UserMark;
  while (!acceptedMarker) {
    print("Select markers X or O :");
    UserMark = stdin.readLineSync();
    print('User Mark : ${UserMark}');
    if (UserMark != "X" && UserMark != "O") {
      print('\n Please Select only X or O capitale litter \n');
      continue;
    } else {
      acceptedMarker = true;
      break;
    }
  }

  print("\n\n******** GAME START ***************\n");
  print(" User play as: ${UserMark}, capital litter");
  if (UserMark == 'O') {
    print(" AI play as: X \n\n");
  } else {
    print(" AI play as: O \n\n");
  }

  List<String> BoardInputs = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
  ];
  printBoard(BoardInputs);
  bool winner = false;

  while (!winner) {
    /// Inform user to insert a number
    print("User, Please select number to insert ${UserMark} : ");

    // Take Input from players
    String? UserInput = stdin.readLineSync();

    // check if the user input it's a number and it's only 1 char
    if ((UserInput!.length != 1 || int.tryParse(UserInput[0]) == null)) {
      print('Please enter number between 1-9 \n');
      continue;
    }

    // Check if the selected postion is empty or not
    if (!positionCheck(BoardInputs, UserInput)) {
      continue;
    }

    /// Update the Board inputs
    int position = int.parse(UserInput.toString());

    /// Update the selected postion with User mark
    BoardInputs[position - 1] = UserMark!;

    /// Check each step if there is a winner or not
    if (isWinner(BoardInputs) != 0) {
      WhoIsTheWinner(BoardInputs, UserMark);

      /// Check if the players wants to reset the game or not
      if (!restartTheGame(BoardInputs)) {
        break;
      }
      winner = false;
      printBoard(BoardInputs);
      continue;
    }

    /// check if the array dosn't have numbers (All board postion is taken)
    if (BoardInputs.every((element) => int.tryParse(element) == null)) {
      printDrawStyle();
      print("\n\n");
      if (!restartTheGame(BoardInputs)) {
        break;
      } else {
        winner = false;
        printBoard(BoardInputs);
        continue;
      }
    }

    /// Switch to Ai to play
    BoardInputs = AiTurn(BoardInputs, UserMark, winner);
    if (isWinner(BoardInputs) != 0) {
      WhoIsTheWinner(BoardInputs, UserMark);
      winner = true;
      if (!restartTheGame(BoardInputs)) {
        break;
      } else {
        winner = false;
        printBoard(BoardInputs);
        continue;
      }
    }

    printBoard(BoardInputs);
  }
}

/// Check if the postion that chosen by the players is empty or not
bool positionCheck(List<String> BoardInputs, String? x) {
  int pos = int.parse(x.toString());
  if (BoardInputs[pos - 1] == 'X' || BoardInputs[pos - 1] == 'O') {
    print('This number is taken \n');
    return false;
  }
  return true;
}

/// Check if there is any winner by check every row,column and diagonal
int isWinner(List<String> arr) {
  for (int i = 0; i < 3; i++) {
    if (arr[i * 3] == arr[i * 3 + 1] &&
            arr[i * 3 + 1] == arr[i * 3 + 2] &&
            arr[i * 3 + 2] == 'X' ||
        arr[i] == arr[i + 3] && arr[i + 3] == arr[i + 6] && arr[i] == 'X' ||
        (arr[0] == arr[4] && arr[4] == arr[8] && arr[8] == 'X' ||
            arr[2] == arr[4] && arr[4] == arr[6] && arr[6] == 'X')) {
      return 1;
    } else if (arr[i * 3] == arr[i * 3 + 1] &&
            arr[i * 3 + 1] == arr[i * 3 + 2] &&
            arr[i * 3 + 2] == 'O' ||
        arr[i] == arr[i + 3] && arr[i + 3] == arr[i + 6] && arr[i] == 'O' ||
        (arr[0] == arr[4] && arr[4] == arr[8] && arr[8] == 'O' ||
            arr[2] == arr[4] && arr[4] == arr[6] && arr[6] == 'O')) {
      return 2;
    }
  }
  return 0;
}

/// Decide which one is the winner
void WhoIsTheWinner(List<String> BoardInputs, String? UserMark) {
  printBoard(BoardInputs);

  if (isWinner(BoardInputs) == 1 && UserMark == 'X') {
    printUserWinningStyle();
  } else if (isWinner(BoardInputs) == 2 && UserMark == 'O') {
    printUserWinningStyle();
  } else {
    printAiWinningStyle();
  }
}

/// The current state of the board
void printBoard(List<String> board) {
  print('\t\t\t ${board[0]} | ${board[1]} | ${board[2]} ');
  print('\t\t\t---+---+---');
  print('\t\t\t ${board[3]} | ${board[4]} | ${board[5]} ');
  print('\t\t\t---+---+---');
  print('\t\t\t ${board[6]} | ${board[7]} | ${board[8]} ');
  print('\n');
}

/// Do you want to restart the game ?
bool restartTheGame(List<String> BoardInputs) {
  print("\n Do you want to restart the game? (y/n)");
  String? answer = stdin.readLineSync();
  if (answer == 'y') {
    /// Reset the board to the first condition
    BoardInputs.clear();
    BoardInputs.addAll(<String>[
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
    ]);
    // printBoard(BoardInputs);
    return true;
  }

  print(" The Game is finsih :)");
  return false;
}

/// What Ai do in his turn
List<String> AiTurn(List<String> BoardInputs, String? UserMark, bool winner) {
  List<int> validPostions = getAllValidPostions(BoardInputs);

  if (validPostions.isEmpty) {
    print('Empty valid postions');
  }
  int aiSelection = validPostions[Random().nextInt(validPostions.length)];
  print("Ai Select : ${aiSelection}");
  UserMark == 'O'
      ? BoardInputs[aiSelection - 1] = 'X'
      : BoardInputs[aiSelection - 1] = 'O';

  return BoardInputs;
}

/// Get all empty places in the board
List<int> getAllValidPostions(List<String> BoardInputs) {
  List<int> validPostions = [];
  for (int i = 0; i < BoardInputs.length; i++) {
    int? toInt = int.tryParse(BoardInputs[i]);
    if (toInt != null) {
      validPostions.add(toInt);
    }
  }
  return validPostions;
}

/// Winning Condition
void printUserWinningStyle() {
  print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  print("!!!!! Congratulation User, You are the winner !!!!!");
  print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
}

void printAiWinningStyle() {
  print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  print("!!!!!! The Ai beat you :) HAhahahhahaaaaaaaa !!!!!!!!!");
  print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
}

/// Draw Condition
void printDrawStyle() {
  print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  print("!!!!!!!!!!!!!!!!!!! No winner :( !!!!!!!!!!!!!!!!!!!!!");
  print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
}
