#include <stdio.h>

long long suite_rec(int n)
{
//    if (n == 0)
//        return 75;
//    else
        return 9 + suite_rec(n-1) + (long long) n * -17;
}
/*
long long suite(int n)
{
    long long prec = 75;
    int i;

    for (i = 1; i <= n; i++)
        prec = 9 + prec + i * -17;
    
    return prec;
}

long long f(int n)
{
    long long ret = 75;
    int i;

    for (i = 1; i <= n; i++)
        ret += i * -17;

    return ret + n * 9;
}*/

int main(void)
{
    printf("%ld", suite_rec(835194));
}
