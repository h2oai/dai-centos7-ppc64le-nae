FROM nimbix/centos-cuda-ppc64le
MAINTAINER Nimbix, Inc.

RUN yum -y install yum-plugin-ovl && yum -y update && yum -y install java 

RUN curl https://s3.amazonaws.com/artifacts.h2o.ai/releases/ai/h2o/dai/1.0.25/ppc64le-centos7/dai-1.0.25-1.ppc64le.rpm --output dai-1.0.25-1.ppc64le.rpm

RUN rpm -ivh dai-1.0.25-1.ppc64le.rpm

RUN chown -R nimbix:nimbix /opt/h2oai

# Expose port 22 for local JARVICE emulation in docker
EXPOSE 22
EXPOSE 12345
EXPOSE 54321

# Nimbix Integrations
COPY NAE/AppDef.json /etc/NAE/AppDef.json
COPY NAE/AppDef.png /etc//NAE/default.png
COPY NAE/screenshot.png /etc/NAE/screenshot.png
