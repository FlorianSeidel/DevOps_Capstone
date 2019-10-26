FROM jenkins/jnlp-slave:3.35-5-jdk11

USER root

#Maven + Python
RUN apt-get install -y maven
RUN apt-get install -y python

#Docker
RUN  apt-get -y install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) \
       stable"
RUN apt-get update

RUN apt-get -y install docker-ce
RUN curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

#Docker compose
RUN ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

#helm
RUN curl -L https://get.helm.sh/helm-v2.15.1-linux-amd64.tar.gz -o helm.tar.gz && \
    mkdir helm && \
    tar -xvzf helm.tar.gz -C helm && \
    mv helm/linux-amd64/helm /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm && \
    ln -s /usr/local/bin/helm /usr/bin/helm && \
    rm helm.tar.gz && \
    rm -rf helm

#chart releaser
RUN curl -L https://github.com/helm/chart-releaser/releases/download/v0.2.2/chart-releaser_0.2.2_linux_amd64.tar.gz \
         -o cr.tar.gz && \
    mkdir cr && \
    tar -xvzf cr.tar.gz -C cr && \
    mv cr/cr /usr/local/bin/cr && \
    chmod +x /usr/local/bin/cr && \
    ln -s /usr/local/bin/cr /usr/bin/cr && \
    rm cr.tar.gz && \
    rm -rf cr


USER jenkins

ENTRYPOINT ["jenkins-slave"]
