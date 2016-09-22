FROM sontn1988/jenkins-slaves
MAINTAINER SONTN

USER jenkins

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3  -y
RUN curl -sSL https://get.rvm.io | bash
RUN source  ~/.rvm/scripts/rvm