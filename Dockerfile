FROM centos/httpd

# update yum
RUN yum update -y && \
    yum clean all

# epel repo
RUN yum install -y epel-release && \
    yum clean all

RUN yum install -y httpd php&& \ # curl git vim pandoc ruby
    yum clean all && \
    systemctl enable httpd.service &&\
    systemctl start httpd

COPY ./index.html /var/www/html/index.html

CMD /sbin/init
