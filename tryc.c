#include <stdio.h>

typedef struct {
  int width;
  int height;
  int depth;
} header;


int getAsciiInt() {
  int i = 0;
  int c;

  while (1) {
    c = getc_unlocked(stdin);
    if (c==EOF || c=='\n' || c==' ') { break; }
    i = i*10 + (c-'0');
  }

  return i;
}

header readHeader() {
  getc_unlocked(stdin);
  getc_unlocked(stdin);
  getc_unlocked(stdin); // P6\n
  header h = {getAsciiInt(), getAsciiInt(), getAsciiInt()};
  return h;
}

void printIntFromStdin() {
  int i = getc_unlocked(stdin);
  if (i>=100) {
    int o = i%10;
    i = i/10;
    int t = i%10;
    i = i/10;
    putc_unlocked('0'+ i, stdout);
    putc_unlocked('0'+ t, stdout);
    putc_unlocked('0'+ o, stdout);
  } else if ( i >= 10) {
    int o = i%10;
    i = i/10;
    putc_unlocked('0'+ i, stdout);
    putc_unlocked('0'+ o, stdout);
  } else {
    putc_unlocked('0'+ i, stdout);
  }
}

int main(void) {
  char mybuf[4096];
  if(setvbuf(stdin, mybuf, _IOFBF, 4096))
    fprintf(stderr, "couldn't buffer stdin\n");

  char mybuf2[4096];
  if(setvbuf(stdout, mybuf2, _IOFBF, 4096))
    fprintf(stderr, "couldn't buffer stdout\n");

  while (1) {
    header h = readHeader();
    for (int y=0; y<h.height; y++) {
      for (int x=0; x<h.width; x++) {
//        printf("\x1b[38;2;%d;%d;%dm█\x1b[0m", getc_unlocked(stdin), getc_unlocked(stdin), getc_unlocked(stdin));
//        fputs("\x1b[38;2;", stdout);
        putc_unlocked('\x1b', stdout); putc_unlocked('[', stdout); putc_unlocked('3', stdout); putc_unlocked('8', stdout); putc_unlocked(';', stdout); putc_unlocked('2', stdout); putc_unlocked(';', stdout);
        printIntFromStdin(); putc_unlocked(';', stdout);
        printIntFromStdin(); putc_unlocked(';', stdout);
        printIntFromStdin();
        //fputs("m█\x1b[0m", stdout);
        putc_unlocked('m', stdout); putc_unlocked('\xe2', stdout); putc_unlocked('\x96', stdout); putc_unlocked('\x88', stdout); putc_unlocked('\x1b', stdout); putc_unlocked('[', stdout); putc_unlocked('0', stdout); putc_unlocked('m', stdout);
      }
      putc_unlocked('\n', stdout);
    }
  }
  return 0;
}
