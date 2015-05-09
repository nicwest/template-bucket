#include <stdio.h>
#include <Foundation/Foundation.h>  

@interface %%BASENAME%%
+ (const char *) classStringValue;
@end

@implementation %%BASENAME%%
+ (const char *) classStringValue;
{
  return "This is the string value of the %%BASENAME%% class";
}
@end

int main(void)
{
  printf("%s\n", [%%BASENAME%% classStringValue]);
  return 0;
}
