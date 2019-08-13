#include <mex.h>
#include <string.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>

// Created by Alexander Fyrdahl <alexander.fyrdahl@gmail.com>

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    int bytes_read = 0;
    char *buffer = (char *)0;

    int sock = (int) mxGetScalar(prhs[0]);
    int length = (int) mxGetScalar(prhs[1]);

    plhs[0] = mxCreateNumericMatrix(length,1,mxUINT8_CLASS,mxREAL);
    buffer =  (char *)mxGetPr(plhs[0]);

    while(bytes_read < length)
        bytes_read += recv(sock,buffer+bytes_read,length-bytes_read,0);

    return;
}
