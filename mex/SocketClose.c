#include <mex.h>
#include <string.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>

// Created by Alexander Fyrdahl <alexander.fyrdahl@gmail.com>

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
