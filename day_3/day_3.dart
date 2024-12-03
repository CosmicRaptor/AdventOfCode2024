import 'dart:io';

void main(){
  File f1 = File('day_3/input.txt');
  String text = f1.readAsStringSync();
  int countOne = 0;
  for(int i =0; i <= text.length - 4; i++){
    if(text.substring(i, i+4) == 'mul('){
      int? result = extractNMultiply(text, i+4);
      if(result != null){
        countOne += result;
      }
    }
  }
  print(countOne);

}

int? extractNMultiply(String arg, int startIndex){
  int closingBracketIndex = arg.indexOf(')', startIndex);
  if(closingBracketIndex == -1) return null;
  String content = arg.substring(startIndex, closingBracketIndex);
  List<String> parts = content.split(',');

  if (parts.length != 2) return null;

  String part1 = parts[0].trim();
  String part2 = parts[1].trim();

  if (isNumeric(part1) && isNumeric(part2)) {
    int num1 = int.parse(part1);
    int num2 = int.parse(part2);
    return num1 * num2;
  }
  return null;
}

bool isNumeric(String s) {
 return int.tryParse(s) != null;
}