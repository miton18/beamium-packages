FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y gdebi-core
ADD target/packages/noderig*.deb var/noderig.deb
RUN gdebi -n /var/noderig.deb

# Various tests and checks
RUN ls -lh /usr/bin/noderig
RUN ls -lh /etc/noderig/config.yaml
RUN ls -lh /var/log/noderig
RUN ls -lh /etc/logrotate.d/noderig
RUN ls -lh /etc/init.d/noderig


CMD ["/bin/bash"]
