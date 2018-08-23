#include <unistd.h>

main ()
{
    printf ("_SC_CLK_TCK = %ld\n", sysconf (_SC_CLK_TCK));
}
