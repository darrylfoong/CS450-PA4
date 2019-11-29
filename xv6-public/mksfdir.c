#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[]){
  int i;
  
  if (argc < 2 ){
    printf(2, "Usage: mksfdir <filenames>\n");
  }
  
  for(i = 1; i < argc; i++){
    if(mksfdir(argv[i]) < 0){
      printf(2, "mksfdir: failed to create %s\n", argv[i]);
      break;
    }
  }

  exit();
}
