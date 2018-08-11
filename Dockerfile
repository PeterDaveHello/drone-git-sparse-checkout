FROM alpine:3.8

MAINTAINER Peter Dave Hello <hsu@peterdavehello.org>
RUN mkdir -p    /root/.ssh/
COPY known_hosts /root/.ssh/
COPY sparseCheckout.sh /bin/
COPY .gitconfig  /root/

RUN echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && \
    apk -U upgrade && \
    apk -v add git@edge openssh-client openssl && \
    rm -rf /var/cache/apk/*

RUN git --version

ENTRYPOINT ["/bin/sparseCheckout.sh"]
