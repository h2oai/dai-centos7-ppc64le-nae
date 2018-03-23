FROM robers97/centos7ppc64le
MAINTAINER Nimbix, Inc.

RUN yum -y update && yum -y wget install zip unzip xz tar file sudo openssh-server openssh-clients infiniband-diags openmpi perftest libibverbs-utils libmthca libcxgb4 libmlx4 libmlx5 dapl compat-dapl passwd && yum clean all

RUN curl -OL https://developer.nvidia.com/compute/cuda/8.0/prod/local_installers/cuda-repo-rhel7-8-0-local-ga2-8.0.54-1.ppc64le-rpm && rpm -ivh cuda-repo-rhel7-8-0-local-ga2-8.0.54-1.ppc64le-rpm && rm -f cuda-repo-rhel7-8-0-local-ga2-8.0.54-1.ppc64le-rpm && yum -y install cuda-toolkit-8-0 && yum clean all && rpm -e cuda-repo-rhel7-8-0-local-ga2

RUN wget https://s3.amazonaws.com/artifacts.h2o.ai/releases/ai/h2o/dai/1.0.25/ppc64le-centos7/dai-1.0.25-1.ppc64le.rpm

RUN rpm -ivh ppc64le-centos7/dai-1.0.25-1.ppc64le.rpm

# Nimbix JARVICE emulation
RUN curl -H 'Cache-Control: no-cache' \
        https://raw.githubusercontent.com/nimbix/image-common/master/install-nimbix.sh \
        | bash

# Expose port 22 for local JARVICE emulation in docker
EXPOSE 22
EXPOSE 12345
EXPOSE 54321

RUN mkdir -p /usr/lib/powerpc64le-linux-gnu
COPY powerpc64le-linux-gnu.conf /etc/ld.so.conf.d/powerpc64le-linux-gnu.conf

# Nimbix Integrations
COPY NAE/AppDef.json /etc/NAE/AppDef.json
COPY NAE/AppDef.png /etc//NAE/default.png
COPY NAE/screenshot.png /etc/NAE/screenshot.png
