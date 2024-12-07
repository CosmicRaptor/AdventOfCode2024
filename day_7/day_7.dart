import 'dart:io';

void main(){
  File f1 = File('day_7/input.txt');
  List<String> lines = f1.readAsLinesSync();
  int count1 = 0;
  for (String line in lines){
    // print(line.split(":"));
    int LHS = int.parse(line.split(':')[0]);
    List<int> rhs = line.split(":")[1].trim().split(' ').map(int.parse).toList();
    if(rhs.length == 1) continue;
    if(rhs.length == 1 && rhs[0] == LHS){
      count1 += LHS;
      continue;
    }
    int numOperators = rhs.length - 1;
    List<List<String>> operatorCombinations = generateOperatorCombinations(numOperators);
    bool isValid = false;
    for (var operators in operatorCombinations) {
      if (evaluateExpression(rhs, operators) == LHS) {
        isValid = true;
        break;
      }
    }
    if (isValid) {
      count1 += LHS;
    }
  }
  print(count1);
}

List<List<String>> generateOperatorCombinations(int count) {
  if (count == 0) return [[]];
  List<List<String>> smallerCombinations = generateOperatorCombinations(count - 1);
  return [
    for (var combination in smallerCombinations) ...[
      [...combination, '+'],
      [...combination, '*'],
      [...combination, '||'],
    ]
  ];
}

int evaluateExpression(List<int> numbers, List<String> operators) {
  int result = numbers[0];
  for (int i = 0; i < operators.length; i++) {
    if (operators[i] == '+') {
      result += numbers[i + 1];
    } else if (operators[i] == '*') {
      result *= numbers[i + 1];
    }
    else if (operators[i] == '||'){
      result = int.parse('$result${numbers[i+1]}');
    }
  }
  return result;
}