FROM ubuntu:14.04
MAINTAINER Dan Vaida <me@danvaida.com>
RUN apt-get -y update && \
    apt-get install -y python-apt \
                       python-yaml \
                       python-httplib2 \
                       python-jinja2 \
                       python-keyczar \
                       python-paramiko \
                       python-pip \
                       python-pkg-resources \
                       python-setuptools

RUN mkdir /etc/ansible
RUN echo '[local]\nlocalhost\tansible_connection=local\n' > /etc/ansible/hosts
RUN pip install --upgrade setuptools pip
RUN pip install ansible==2.2

COPY run-tests.sh run-tests.sh
CMD ["./run-tests.sh"]
