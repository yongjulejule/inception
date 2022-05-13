#include <signal.h>
#include <unistd.h>
#include <stdio.h>

void sig_handler(int sig) {
fprintf(stderr, "sig receive %d\n", sig);
pause();

}

int main(){

signal(SIGTERM, sig_handler);

pause();

}
