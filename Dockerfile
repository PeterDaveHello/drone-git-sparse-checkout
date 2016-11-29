FROM alpine:edge
MAINTAINER Peter Dave Hello <hsu@peterdavehello.org>
RUN mkdir -p    /root/.ssh/
ADD known_hosts /root/.ssh/
ADD sparseCheckout.sh /bin/
ADD .gitconfig  /root/
RUN apk -Uuv add git openssh-client openssl
ENTRYPOINT /bin/sparseCheckout.sh
