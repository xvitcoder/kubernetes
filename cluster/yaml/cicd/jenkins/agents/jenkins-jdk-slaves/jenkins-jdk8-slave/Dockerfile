FROM openjdk:8-slim
LABEL maintainer="CN Services <xvitcoder@gmail.com>"

RUN apt -y update && \
    mkdir -p /usr/share/man/man1 && \
    apt -y install git wget maven curl unzip

RUN groupadd -g 10000 jenkins && \
    useradd -r -m -u 10000 -g jenkins jenkins

USER jenkins

ENV USER_HOME_DIR /home/jenkins
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

WORKDIR /home/jenkins

CMD ["/bin/sh"]

