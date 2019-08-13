#include <mex.h>
#include <string.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>

// Created by Alexander Fyrdahl <alexander.fyrdahl@gmail.com>

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    int port;
    int *sock;

    struct sockaddr_in server;

    plhs[0] = mxCreateNumericMatrix(1,1,mxINT32_CLASS,mxREAL);

    sock = (int *)mxGetPr(plhs[0]);
    port = (int) mxGetScalar(prhs[0]);

    if((sock[0] = socket(AF_INET,SOCK_STREAM,0)) == -1)
    {
        mexErrMsgTxt("Could not create socket!");
        return;
    }

    server.sin_family = AF_INET;
    server.sin_addr.s_addr = INADDR_ANY;
    server.sin_port = htons(port);

    if( bind(sock[0],(struct sockaddr *)&server, sizeof(server)) < 0)
    {
       close(sock[0]);
       sock[0] = -1;
       mexErrMsgTxt("Bind failed!");
    }

    if(listen(sock[0],100)== -1)
    {
		close(sock[0]);
		sock[0] = -1;
		mexErrMsgTxt("Could not listen!");
	}

    return;
}
