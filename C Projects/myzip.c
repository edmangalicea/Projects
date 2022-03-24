#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
  if (argc < 2)
  {
    printf("Usage: %s FILENAME\n", argv[0]);
    exit(1);
  }
  FILE *fp = fopen(argv[1], "r");
  static char buf[20000000]; /* input string */
  int count[] = {0};

  fread(buf, sizeof(char), 20000000, fp);

  for (int i = 0; buf[i] != '\0'; i++)
  { /*loop until end of string */

    count[0] = 1;
    while (buf[i] == buf[i + 1])
    {
      count[0]++;
      i++;
    }

    fwrite(count,sizeof(int),1,stdout);
    fputc(buf[i], stdout);
  }

  fclose(fp);
  return 0;
}
