#include <mex.h>
#include <string.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>

// Created by Alexander Fyrdahl <alexander.fyrdahl@gmail.com>

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    int sock;
    int bytes_sent = 0;
    unsigned char *buffer;
    int length = (int) (mxGetNumberOfElements(prhs[1])*mxGetElementSize(prhs[1]));

    sock = (int)mxGetScalar(prhs[0]);

    buffer = (unsigned char *)mxGetPr(prhs[1]);
    while(bytes_sent < length)
        bytes_sent += send(sock,buffer+bytes_sent,length-bytes_sent,0);

    return;
}
