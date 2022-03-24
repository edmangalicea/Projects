#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char *argv[])

  {
    
    if (argc < 3  || argc > 3)
    {
      printf("Usage: %s STRING1 STRING2\n", argv[0]);
      printf("       %s -d STRING\n", argv[0]);
      exit(1);
    }
    /*
    if ((strlen (argv[1]) != strlen(argv[2])) && !((strcmp(argv[1], "-d") == 0))){
      printf("STRING1 and STRING2 must have the same length\n");
      exit(1);
    }
    */
   if (!((strcmp(argv[1],"-d")==0)) && ((strlen(argv[1])) != (strlen(argv[2]))) ){
        printf("STRING1 and STRING2 must have the same length");
        exit(1);
    }
    
  char a[1000];
 /* char buf[1000]; */
  /* char *ret; */
  //char b[1000] = {0};
  
  while (fgets(a, 1000, stdin) != NULL){ 

  if (strcmp(argv[1], "-d") == 0){
  
    
    for(int d = 0; a[d] != '\0'; d++){
    int check=1;
    for(int i = 0; argv[2][i] != '\0'; i++){

      

        if(a[d] == argv[2][i]){
          check=0;
          //b[d] = 1;
        }
        
      }
      if(check==1){
        printf("%c",a[d]);
      }

    }
    
     



  /*
        for (int i = 0; a[i] != '\0'; i++)
      {
        b = 0;
        for (int d = 0; argv[2][d] != '\0'; d++)
        {
          if (a[i] == argv[2][d])
          {
          break;
            
          }else{
            strcat(b, a[i]);
            printf("%c", a[i]);
            break;
        }
  

          }
          printf("%s", b);
        
      }


    

      for{
        char b;
      };




  */


    
  
  
  }else{
    

      for (int i = 0; a[i] != '\0'; i++)
      {
        for (int d = 0; argv[1][d] != '\0'; d++)
        {
          
          if (a[i] == argv[1][d])
          {
            a[i] = argv[2][d];
            
          }

            }
          }
          
       printf("%s", a); 
        }
      
      
    }

  return 0;

  }
