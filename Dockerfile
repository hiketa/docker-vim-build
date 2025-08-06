#FROM fedora:36
#FROM rockylinux:9
FROM rockylinux:10
#FROM ubuntu:22.04

COPY build.sh /usr/local/bin/build.sh

CMD ["/usr/local/bin/build.sh"]
