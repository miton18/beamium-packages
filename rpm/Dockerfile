FROM centos:latest

RUN apt-get update
ADD target/packages/noderig*.rpm var/noderig.rpm
RUN rpm -i /var/noderig.rpm

# Various tests and checks
RUN ls -lh /usr/bin/noderig
RUN ls -lh /etc/noderig/config.yaml
RUN ls -lh /var/log/noderig
RUN ls -lh /etc/logrotate.d/noderig
RUN ls -lh /etc/init.d/noderig


CMD ["/bin/bash"]
