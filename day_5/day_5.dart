import 'dart:io';

void main(){
  File f1 = File('day_5/input.txt');
  List<String> lines = f1.readAsLinesSync();
  List<List<int>> rules = [];
  List<List<int>> pagesToUpdate = [];
  bool isRules = true;
  int count1 = 0, count2 = 0;
  for (String line in lines){
    if (line == ''){
      isRules = false;
    }
    if (isRules){
      rules.add(line.split('|').map(int.parse).toList());
    }
    if (!isRules){
      if (line != ''){
        pagesToUpdate.add(line.split(',').map(int.parse).toList());
      }
    }
  }
  for (List<int> item in pagesToUpdate){
    count1 += getMiddle(item, rules);
  }
  // print(rules);
  // print(pagesToUpdate);
  print(count1);
  print(count2);
}

int getMiddle(List<int> line, List<List<int>> rules){
  int count = 0;
  bool isValid = true;
  print('The line is $line');
  for(int i = 0; i < line.length; i++){
    int number = line[i];
    List<List<int>> relevantRules = rules.where((item) => item.contains(number)).toList();
    // print('The ruleset is $relevantRules');
    for (List<int> rule in relevantRules) {
      int indexX = line.indexOf(rule[0]);
      int indexY = line.indexOf(rule[1]);
      if (indexX != -1 && indexY != -1 && indexX >= indexY) {
        isValid = false;
        break;
      }
    }
  }
  if(isValid){
    count = line[(line.length /2).floor()];
    print('Valid line $count');
  }
  return count;
}