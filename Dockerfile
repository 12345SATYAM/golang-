#golang version -- 1.17.3 --

FROM golang:1.17.3

MAINTAINER Nageshwar Pratap Singh <nageshwar1.singh@paytm.com>

RUN apt-get update && apt-get install ncftp openssh-client lftp thrift-compiler rsync zip unzip -y
ENV PATH /usr/local/go/bin:$PATH
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.44.2

RUN wget https://github.com/frekele/oracle-java/releases/download/8u211-b12/jre-8u211-linux-x64.tar.gz

RUN tar -zxvf jre-8u211-linux-x64.tar.gz -C /opt/
RUN ln -s /opt/jre1.8.0_211/bin/java /usr/bin/java

# sonar setup
RUN curl --insecure -o /opt/sonarscanner.zip -L https://repo1.maven.org/maven2/org/sonarsource/scanner/cli/sonar-scanner-cli/4.6.2.2472/sonar-scanner-cli-4.6.2.2472-linux.zip \
        && unzip /opt/sonarscanner.zip -d /opt/ \
        && rm /opt/sonarscanner.zip
#COPY sonar-runner.properties /opt/sonar-scanner-4.6.2.2472-linux/conf/sonar-scanner.properties

# environment setup
ENV SONAR_RUNNER_HOME /opt/sonar-scanner-4.6.2.2472-linux
ENV PATH $PATH:/opt/sonar-scanner-4.6.2.2472-linux/bin

#   ensure Sonar uses the provided Java for musl instead of a borked glibc one
RUN sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' /opt/sonar-scanner-4.6.2.2472-linux/bin/sonar-scanner

# gopath setup
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH


RUN adduser --home /home/jenkins  jenkins
RUN mkdir /home/jenkins/.ssh && chmod 700 /home/jenkins/.ssh
RUN chown -R jenkins:jenkins /home/jenkins/.ssh
USER jenkins