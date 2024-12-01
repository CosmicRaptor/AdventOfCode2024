import 'dart:io';
import 'dart:core';

void main(){
    File f1 = File("day_1/input.txt");
    List<String> lines = f1.readAsLinesSync(), templine;
    List<int> l1 = [], l2 = [];
    int diff = 0;

    for(int i = 0; i < lines.length; i++){
        templine = lines[i].split('   ');
        print(templine);
        l1.add(int.parse(templine[0]));
        l2.add(int.parse(templine[1]));
    }

    l1.sort();
    l2.sort();
    // print(l1);
    for(int i = 0; i < l1.length; i++){
        diff += (l1[i] - l2[i]).abs();
    }
    print(diff);

    //part 2
    int similarityScore = 0;
    for(int i =0; i < l1.length; i++){
        int count = 0;
        l2.forEach((element){
            if(l1[i] == element){
                count++;
            }
        });
        similarityScore += l1[i] * count;
    }
    print(similarityScore);
}