#include <mex.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/select.h>
#include <arpa/inet.h>

// Created by Alexander Fyrdahl <alexander.fyrdahl@gmail.com>

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    int server_sock = (int) mxGetScalar(prhs[0]);
    struct sockaddr_in client;
    int c = sizeof(struct sockaddr_in);

    plhs[0] = mxCreateNumericMatrix(1,1,mxINT32_CLASS,mxREAL);
    ((int *)mxGetPr(plhs[0]))[0] = (int) accept(server_sock,(struct sockaddr *)&client,(socklen_t *)&c);

    if(nlhs > 1)
        plhs[1] = mxCreateString(inet_ntoa(client.sin_addr));

	return;
}
