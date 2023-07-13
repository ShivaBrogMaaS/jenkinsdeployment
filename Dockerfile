#Base Image Configuration:
FROM ubuntu:18.04
#Install packages in the Docker image
RUN  apt-get upgrade
RUN  apt-get update
RUN  apt-get -y install wget
RUN  apt-get -y install tar
RUN  apt-get -y install unzip
RUN  apt-get -y install alien
RUN  apt-get -y install curl
RUN  apt install -y openjdk-11-jdk
#set the working directory of a Docker container
WORKDIR "/app"
#Tomcat Configuration
RUN groupadd tomcat
RUN useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
RUN cd /tmp
RUN curl -O https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.78/bin/apache-tomcat-9.0.78.tar.gz
RUN rm -rvf /opt/tomcat
RUN mkdir /opt/tomcat
RUN tar xf apache-tomcat-9*tar.gz -C /opt/tomcat --strip-components=1
RUN cd /opt/tomcat
RUN chgrp -R tomcat /opt/tomcat
RUN chmod -R g+r /opt/tomcat/conf
RUN chmod g+x /opt/tomcat/conf
RUN chown -R tomcat /opt/tomcat/webapps /opt/tomcat/work /opt/tomcat/temp /opt/tomcat/logs
RUN cd /opt/tomcat/bin
#Download the require war files for tomcat
RUN cd /
RUN curl -O http://j-trac.sourceforge.net/files/jtrac.war
#Copy the War file to tomcat to webapps folder
RUN cd /
RUN mv jtrac.war /opt/tomcat/webapps/
#Port opening for the tomcat
EXPOSE  8080
#Start the tomcat
CMD /opt/tomcat/bin/catalina.sh run
