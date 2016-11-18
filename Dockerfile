FROM peterdavehello/alpine-git:latest
MAINTAINER Peter Dave Hello <hsu@peterdavehello.org>
ADD sparseCheckout.sh /bin/
ENTRYPOINT /bin/sparseCheckout.sh
