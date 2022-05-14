#include <signal.h>
#include <unistd.h>
#include <stdio.h>

void sig_handler(int sig) {
fprintf(stderr, "sig receive %d\n", sig);
}

int main(){

signal(SIGTERM, sig_handler);
signal(SIGINT, sig_handler);
signal(SIGQUIT, sig_handler);

while (1) usleep(10000);

}
