FROM resin/raspberrypi3-alpine-buildpack-deps:latest
RUN echo "ipv6" >> /etc/modules
RUN echo "http://dl-2.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories; \
    echo "http://dl-3.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories; \
    echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories; \
    echo "http://dl-5.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add --update go git
RUN apk add --no-cache wiringpi
RUN apk add gcc
RUN apk add sudo
RUN apk add --update linux-headers
#RUN apk add --update linux-libc-dev

# Set up GOPATH
RUN mkdir /go
ENV GOPATH /go
#RUN echo "ipv6" >> /etc/modules

RUN git clone git://git.drogon.net/wiringPi
RUN cd wiringPi
#RUN git pull origin 
RUN --update
#RUN cd wiringPi && ./build uninstall 
#RUN ./build

RUN apk --update add --no-cache git openssh-client curl zip unzip bash ttf-dejavu && rm -rf /var/cache/apk/*
#RUN unzip wiringPi-96344ff.tar.gz
RUN tar -xfz wiringPi-96344ff.tar.gz
RUN cd wiringPi-96344ff.tar.gz
RUN ./build

#RUN cd wiringPi
#RUN pip install wiringpi2


COPY . /wiringPi
WORKDIR /wiringPi

RUN gcc -o pub.o pub.c -lwiringPi 

CMD ./pistart.sh