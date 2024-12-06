import 'dart:io';

void main() {
  Walker walker = Walker.fromFile('day_6/input.txt');
  walker.run();
}

class Walker {
  final List<List<String>> grid;
  List<int> coords = [0, 0];
  String currDir = 'top';
  Set<String> visited = {};
  Set<String> stateHistory = {};

  Walker(this.grid);

  // Factory constructor to initialize from a file
  factory Walker.fromFile(String filePath) {
    File file = File(filePath);
    List<String> lines = file.readAsLinesSync();
    List<List<String>> grid =
        lines.map((String element) => element.split("")).toList();
    return Walker(grid);
  }

  void initializePosition() {
    for (int y = 0; y < grid.length; y++) {
      for (int x = 0; x < grid[y].length; x++) {
        if (grid[y][x] == '^') {
          coords = [x, y];
          visited.add('${coords[0]},${coords[1]}');
          return;
        }
      }
    }
  }

  void walk() {
    Map<String, List<int>> directions = {
      'top': [0, -1],
      'right': [1, 0],
      'bottom': [0, 1],
      'left': [-1, 0]
    };

    // stateHistory = {'${coords[0]},${coords[1]},$currDir'};

    while (true) {
      int dx = directions[currDir]![0];
      int dy = directions[currDir]![1];
      int newX = coords[0] + dx;
      int newY = coords[1] + dy;

      if (newX < 0 ||
          newY < 0 ||
          newY >= grid.length ||
          newX >= grid[newY].length) {
        return; // Out of bounds
      }

      if (grid[newY][newX] == '.' || grid[newY][newX] == '^') {
        // Move forward
        coords[0] = newX;
        coords[1] = newY;
        visited.add('${coords[0]},${coords[1]}');
      } else {
        // Turn right
        currDir = changeDir(currDir);
      }

      String currentState = '${coords[0]},${coords[1]},$currDir';
      if (stateHistory.contains(currentState)) {
        throw InfiniteLoopException();
      }
      stateHistory.add(currentState);
    }
  }

  void run() {
    // Part 1: Walk and count distinct positions
    initializePosition();
    walk();
    print("Distinct positions visited: ${visited.length}");
    // print(visited);

    // Part 2: Find infinite loop counts for modified grids
    resetState();
    int infiniteLoopCount = 0;
    for (String pos in Set.from(visited)) {
      if (pos == '${coords[0]},${coords[1]}') continue;

      List<int> testPos = pos.split(',').map(int.parse).toList();
      grid[testPos[1]][testPos[0]] = '#';

      resetState();

      try {
        // print("hehehe");
        walk();
      } catch (e) {
        // print(e.toString());
        if (e is InfiniteLoopException) {
          infiniteLoopCount++;
        }
      }

      // Restore the grid after modification
      grid[testPos[1]][testPos[0]] = '.';
    }

    print("Infinite loop count: $infiniteLoopCount");
  }

  void resetState() {
    coords = [0, 0]; // Reset the coordinates to the initial position
    initializePosition(); // Find the initial position again
    currDir = 'top'; // Reset direction
    stateHistory.clear(); // Clear state history for the new walk
  }

  String changeDir(String currDir) {
    if (currDir == 'top') return 'right';
    if (currDir == 'right') return 'bottom';
    if (currDir == 'bottom') return 'left';
    return 'top';
  }
}

class InfiniteLoopException implements Exception {}
