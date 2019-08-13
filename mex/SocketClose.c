#include <mex.h>
#include <string.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>

// Alexander Fyrdahl, 2019

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    int sock = -1;

    if(!mxIsNumeric(prhs[0]))
        return;

    sock = (int) mxGetScalar(prhs[0]);

    if(sock==-1)
        return;

    shutdown(sock,SHUT_RDWR);
    close(sock);
    return;
}
