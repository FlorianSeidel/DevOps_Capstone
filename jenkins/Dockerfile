# Used
# https://www.popularowl.com/jenkins/automating-jenkins-install-docker-terraform/
# https://github.com/tknerr/jenkins-pipes-infra
# https://github.com/samrocketman/jenkins-bootstrap-shared/blob/master/scripts/configure-github-plugin.groovy
# https://github.com/Praqma/JenkinsAsCodeReference/blob/master/dockerizeit/master/credentials.groovy
# https://github.com/buildit/jenkins-startup-scripts
# as reference
FROM jenkins/jenkins:lts-alpine

ENV JENKINS_UC https://updates.jenkins.io

RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion

# install jenkins plugins
RUN  /usr/local/bin/install-plugins.sh job-dsl \
                                       git \
                                       workflow-aggregator \
                                       blueocean \
                                       matrix-auth \
                                       maven-plugin

# create the seed job which spawns all other jobs
RUN mkdir -p /usr/share/jenkins/ref/jobs/seed-job
COPY seedJob.xml /usr/share/jenkins/ref/jobs/seed-job/config.xml

ENV JENKINS_USER admin
ENV JENKINS_PASS admin

# allows to skip Jenkins setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Jenkins runs all grovy files from init.groovy.d dir
# use this for creating default admin user
COPY default-user.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY disable-script-security.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY github-credentials.groovy /usr/share/jenkins/ref/init.groovy.d/
# volume for Jenkins settings
VOLUME /var/jenkins_home