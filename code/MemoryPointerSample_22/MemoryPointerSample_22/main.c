//
//  main.c
//  MemoryPointerSample_23
//
//  Created by 丰源天下传媒 on 2022/10/1.
//

#include <stdio.h>


int main(int argc, const char * argv[]) {
   
   int x = 20;
   int* xPointer = &x;

   printf("1. 变量x的地址: `%p`\n", &x);
   printf("2. 变量x的值: `%u`\n", x);
   printf("3. 变量xPointer的地址: `%p`\n", &xPointer);
   printf("4. 变量xPointer的值: `%p`\n", xPointer); // 和变量x 的地址是一样的。
  
   printf("5. 变量xPointer所指向地址的值: `%u`\n", *xPointer);
   
   *xPointer = 90;
   printf("6. 变量x的值: `%u`\n", x);
   printf("7. 变量xPointer所指向地址的值: `%u`\n", *xPointer);

   x = 100;
   printf("8. 变量x的值: `%u`\n", x);
   printf("9. 变量xPointer所指向地址的值: `%u`\n", *xPointer);

   return 0;
}
