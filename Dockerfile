FROM centos:7

RUN yum -y update

RUN yum -y install epel-release

RUN yum -y install ansible