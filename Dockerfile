FROM alpine:latest

RUN apk add --update git gcc make libc-dev

RUN git clone https://github.com/janet-lang/janet /usr/src/janet && cd /usr/src/janet && make && make install
RUN git clone https://github.com/sysread/skewheap-janet /usr/src/skewheap

WORKDIR /usr/src/skewheap
RUN jpm deps

CMD /usr/local/bin/jpm test
