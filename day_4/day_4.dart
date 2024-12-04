import 'dart:io';

void main() {
  File f1 = File('day_4/input.txt');
  List<String> lines = f1.readAsLinesSync();
  int count = 0;
  for (int i = 0; i < lines.length; i++) {
    String temp1 = lines[i];
    count += horizontalScan(temp1);
    count += horizontalScan(temp1.split("").reversed.join());
    List<String> chars = [];
    for (int j = 0; j < lines.length; j++) {
      chars.add(lines[j][i]);
    }
    count += horizontalScan(chars.join());
    count += horizontalScan(chars.reversed.join());
  }
  // print(count);
  //positive diagonals
  int rows = lines.length;
  int cols = lines[0].length;

  for (int start = 0; start < rows + cols - 1; start++) {
    List<String> diagonal = [];

    for (int row = 0; row <= start; row++) {
      int col = start - row;
      if (row < rows && col < cols) {
        diagonal.add(lines[row][col]);
      }
    }
    if (diagonal.length >= 4) {
      // print(diagonal.join());
      count += horizontalScan(diagonal.join());
      count += horizontalScan(diagonal.reversed.join());
    }
  }
  //negative diagonals
  for (int start = 0; start < rows + cols - 1; start++) {
    List<String> diagonal = [];

    for (int row = 0; row <= start; row++) {
      int col = cols - 1 - (start - row);
      if (row < rows && col >= 0) {
        diagonal.add(lines[row][col]);
      }
    }
    if (diagonal.length >= 4) {
      // print(diagonal.join());
      count += horizontalScan(diagonal.join());
      count += horizontalScan(diagonal.reversed.join());
    }
  }
  print(count);

  //part 2 from here

  int count2 = 0;
  for (int i = 0; i <= lines.length - 3; i++) {
    for (int j = 0; j <= lines[0].length - 3; j++) {
      List<String> selectedGrid = [];

      for (int k = 0; k < 3; k++) {
        selectedGrid.add(lines[i + k].substring(j, j + 3));
      }

      // print(selectedGrid);
      count2 += gridScan(selectedGrid);
    }
  }
  print(count2);
}

int horizontalScan(String line) {
  int count = 0;
  for (int i = 0; i <= line.length - 4; i++) {
    if (line.substring(i, i + 4) == 'XMAS') {
      count += 1;
    }
  }
  return count;
}

int gridScan(List<String> grid){
  int count = 0;
  if(((grid[0][0] == 'M' && grid[2][2] == 'S') || (grid[0][0] == 'S' && grid[2][2] == 'M')) && grid[1][1] == 'A'){
    if((grid[0][2] == 'M' && grid[2][0] == 'S') || (grid[0][2] == 'S' && grid[2][0] == 'M')){
      count+=1;
    }
  }
  return count;
}
