FROM alpine
ENV DOCKER_VERSION 1.12.0
ENV DOCKER_COMPOSE_VERSION 1.8.0
ENV DOCKER_MACHINE_VERSION 0.7.0
ENV TERM xterm

RUN apk --update add openjdk8-jre openssh git curl && \
    rm -rf /var/cache/apk/* 

RUN addgroup jenkins && \
    adduser -D jenkins -s /bin/sh -G jenkins && \
    chown -R jenkins:jenkins /home/jenkins && \
    echo "jenkins:jenkins" | chpasswd

#Docker bins
WORKDIR     /home/jenkins/
RUN         curl -L -o /tmp/docker-latest.tgz https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz && \
            tar -xvzf /tmp/docker-latest.tgz && \
            mv docker/* /usr/bin/ 

#Docker compose
RUN 		curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
			chmod +x /usr/local/bin/docker-compose
  
RUN mkdir  /home/jenkins/.ssh

COPY /files/authorized_keys /home/jenkins/.ssh/authorized_keys
COPY /files/config /home/jenkins/.ssh/config

RUN chown -R jenkins: /home/jenkins
RUN chmod 600 /home/jenkins/.ssh/authorized_keys
RUN chmod 644 /home/jenkins/.ssh/config
RUN chmod 700 /home/jenkins/.ssh

# Comment these lines to disable sudo
RUN apk --update add sudo && \
    rm -rf /var/cache/apk/* && \
    echo "%jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

EXPOSE 22
CMD ["sudo", "/usr/sbin/sshd", "-D"]