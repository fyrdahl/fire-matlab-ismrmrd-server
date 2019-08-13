FROM ubuntu:18.04
LABEL maintainer="Alexander Fyrdahl (alexander.fyrdahl@gmail.com)"
RUN apt-get update --quiet && \
    apt-get install --no-install-recommends --no-install-suggests --yes  \
       git octave liboctave-dev octave-io default-jre-headless libjaxp1.3-java libxerces2-java \
    && rm -rf /var/lib/apt/lists/* \
    && echo "more off; pkg load io;" > ~/.octaverc \
    && mkdir -p /opt/code/ \
    && cd /opt/code/ \
    && git clone https://github.com/fyrdahl/fire-matlab-ismrmrd-server.git \
    && cd /opt/code/fire-matlab-ismrmrd-server/mex  \
    && mkoctfile --mex ServerSocket.c \
    && mkoctfile --mex SocketAccept.c \
    && mkoctfile --mex SocketClose.c \
    && mkoctfile --mex SocketRead.c \
    && mkoctfile --mex SocketWrite.c \
    && apt-get remove --purge -y git ca-certificates \
    && apt-get autoremove -y

CMD octave-cli --path "/opt/code/fire-matlab-ismrmrd-server/" --eval "fire_matlab_ismrmrd_server"
