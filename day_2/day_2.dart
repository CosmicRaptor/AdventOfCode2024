import 'dart:io';

void main() {
  File f1 = File('day_2/input.txt');
  List<String> lines = f1.readAsLinesSync();
  List<int> numbers = [];
  int countFirst = 0;
  int countSecond = 0;

  for (String element in lines) {
    print('Checking $element');
    numbers.clear();
    numbers.addAll(element.split(' ').map(int.parse));
    if(isSafe(numbers)){
      countFirst++;
    }
    else {
      for(int i = 0; i < numbers.length; i++){
        List<int> modified = numbers.sublist(0,i) + numbers.sublist(i+1);
        if(isSafe(modified)){
          countSecond++;
          break;
        }
      }
    }
  }
  print(countFirst);
  print(countFirst + countSecond);
}

bool isSafe(List<int> numbers) {
  String s1 = '';
  String status = 'safe';
  if (numbers[0] > numbers[1]) {
    s1 = 'decr';
  } else if (numbers[0] < numbers[1]) {
    s1 = 'incr';
  } else {
    return false;
  }
  print(s1);

  for (int i = 0; i < numbers.length; i++) {
    if (i != numbers.length - 1) {
      if (numbers[i] == numbers[i + 1]) {
        print(1);
        status = 'unsafe';
        break;
      }
      if (numbers[i] > numbers[i + 1]) {
        if (s1 == 'decr') {
          if (numbers[i] - numbers[i + 1] > 3) {
            print(2);
            status = 'unsafe';
            break;
          }
        } else {
          print(3);
          status = 'unsafe';
          break;
        }
      }
      if (numbers[i] < numbers[i + 1]) {
        if (s1 == 'incr') {
          if (numbers[i + 1] - numbers[i] > 3) {
            print(4);
            status = 'unsafe';
            break;
          }
        } else {
          print(5);
          status = 'unsafe';
          break;
        }
      }
    }
  }
  if (status == 'safe') {
    return true;
  } else
    return false;
}
