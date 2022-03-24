#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  if (argc < 2) {
    printf("Usage: %s FILENAME\n", argv[0]);
    
    exit(1);
  }
  

  FILE *fp = fopen(argv[1],"r"); 
 char buf[1000];  /* input string */    
 int cuf[1000];
 int i = 0;
/*

while(1){

 int nread = fread(cuf,sizeof(int),1,fp);
 printf("%d", cuf[i] );
if(nread != 1){
  break;
}
  
}
*/



while(1){

int nread = fread(cuf,sizeof(int),1,fp);

int tread = fread(buf,1,1,fp);

if(feof(fp)){
  break;
}



for(int i = 0; cuf[0] > i; i++ ){
  
  printf("%c", buf[0]);
}

}








/*

fread(cuf,sizeof(int),1,fp);
printf("%d", cuf[i] );




fread(buf,1,1,fp);

printf("%c", buf[i]);


*/



 /*
  fread(buf,sizeof(char),1,fp);
  printf("%c", buf[i]);
 
*/


fclose(fp);
  return 0;
}


