import 'dart:io';

void main() {
  print(" Player 1 : X, capital litter");
  print(" Player 2 : O, capital litter \n\n");
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
  bool WhoIsPlay = true;
  int player = 0;
  while (!winner) {
    WhoIsPlay == true ? player = 1 : player = 2;
    print("Player ${player} Please select number to insert X: ");
    String? x = stdin.readLineSync();
    if (!positionCheck(BoardInputs, x)) {
      continue;
    }
    int pos = int.parse(x.toString());
    WhoIsPlay == true ? BoardInputs[pos - 1] = 'X' : BoardInputs[pos - 1] = 'O';
    if (isWinner(BoardInputs) != 0) {
      if (isWinner(BoardInputs) == 1) {
        printWinnerStyle(1);
      } else {
        printWinnerStyle(2);
      }
      print("\n Do you want to restart the game? (y/n)");
      String? ans = stdin.readLineSync();
      if (ans == 'y') {
        BoardInputs = [
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
        WhoIsPlay = true;
        continue;
      } else {
        print(" The Game is finsih :)");
      }
    }
    printBoard(BoardInputs);
    WhoIsPlay = !WhoIsPlay;
  }
}

bool positionCheck(List<String> BoardInputs, String? x) {
  int pos = int.parse(x.toString());
  if (BoardInputs[pos - 1] == 'X' || BoardInputs[pos - 1] == 'O') {
    return false;
  }
  return true;
}

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

void printWinnerStyle(int p) {
  print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  print("!!!!! Congratulation Player${p}, You are the winner !!!!!");
  print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
}

void printBoard(List<String> board) {
  print(' ${board[0]} | ${board[1]} | ${board[2]} ');
  print('---+---+---');
  print(' ${board[3]} | ${board[4]} | ${board[5]} ');
  print('---+---+---');
  print(' ${board[6]} | ${board[7]} | ${board[8]} ');
  print('\n');
}
