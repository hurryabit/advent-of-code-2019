// day02-2.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int main() {
  int input[153] = {1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,9,19,1,5,19,23,1,6,23,27,1,27,10,31,1,31,5,35,2,10,35,39,1,9,39,43,1,43,5,47,1,47,6,51,2,51,6,55,1,13,55,59,2,6,59,63,1,63,5,67,2,10,67,71,1,9,71,75,1,75,13,79,1,10,79,83,2,83,13,87,1,87,6,91,1,5,91,95,2,95,9,99,1,5,99,103,1,103,6,107,2,107,13,111,1,111,10,115,2,10,115,119,1,9,119,123,1,123,9,127,1,13,127,131,2,10,131,135,1,135,5,139,1,2,139,143,1,143,5,0,99,2,0,14,0};
  int memory[153];

  for (int x = 0; x < 100; ++x) {
    for (int y = 0; y < 100; ++y) {
      memcpy(memory, input, 153 * sizeof(int));
      memory[1] = x;
      memory[2] = y;
      int i = 0;
      while (memory[i] != 99) {
        switch (memory[i]) {
          case 1:
            memory[memory[i+3]] = memory[memory[i+1]] + memory[memory[i+2]];
            break;
          case 2:
            memory[memory[i+3]] = memory[memory[i+1]] * memory[memory[i+2]];
            break;
          default:
            printf("Bad instruction: %d\n", memory[i]);
            exit(1);
        }
        i += 4;
      }
      if (memory[0] == 19690720) {
        printf("Result: %d\n", 100*x+y);
      }
    }
  }
  return 0;
}
