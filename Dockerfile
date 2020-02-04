FROM centos/httpd

# update yum
RUN yum update -y && \
    yum clean all

# epel repo
RUN yum install -y epel-release && \
    yum clean all

RUN yum install -y httpd php curl git vim pandoc ruby sudo&& \
    yum clean all

COPY ./index.html /var/www/html/index.html

CMD /sbin/init
