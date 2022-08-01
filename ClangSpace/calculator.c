#include <stdio.h>
#include <string.h>
int main(int argc, char *argv[])
{
    if(argc <= 3)
    {
        printf("args error\n");
        return -1;
    }
    int a = 0, b = 0;
    double ans = 0;
    for(int i = strlen(argv[1]) - 1, order = 1; i >= 0; i--, order *= 10)
        a += (argv[1][i] - 48) * order;
    for(int i = strlen(argv[3]) - 1, order = 1; i >= 0; i--, order *= 10)
        b += (argv[3][i] - 48) * order;
    switch (argv[2][0])
    {
        case '+': ans = a + b; break;
        case '-': ans = a - b; break;
        case '/': ans = a * 1. / b; break;
        case '%': ans = a % b; break;
        case '*': ans = a * b; break;
        default: break;
    }
    printf("%d %c %d = %lf\n", a, argv[2][0], b, ans);
    return 0;
}