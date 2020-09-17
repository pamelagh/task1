#---------------------------- Get base image
FROM debian:latest

#--------------------------- Install Apache Tomcat 8
USER root

# 1. Install Java and curl
RUN apt-get update \
  && yes | apt-get install default-jdk wget

# 2. Install Tomcat
RUN mkdir /usr/local/tomcat
RUN wget https://downloads.apache.org/tomcat/tomcat-8/v8.5.57/bin/apache-tomcat-8.5.57.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-8.5.57/* /usr/local/tomcat/

# 3. Create a systemd Service File
RUN echo '[Unit]\n\
Description=Apache Tomcat Web Application Container\n\
After=network.target\n\
[Service]\n\
Type=forking\n\
Environment="JAVA_HOME=/usr/lib/jvm/default-java"\n\
Environment="CATALINA_PID=/opt/tomcat/temp/tomcat.pid"\n\
Environment="CATALINA_HOME=/opt/tomcat"\n\
Environment="CATALINA_BASE=/opt/tomcat"\n\
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"\n\
Environment="JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"\n\
ExecStart=/opt/tomcat/bin/startup.sh\n\
ExecStop=/opt/tomcat/bin/shutdown.sh\n\
User=tomcat\n\
Group=tomcat\n\
RestartSec=10\n\
Restart=always\n\
[Install]\n\
WantedBy=multi-user.target\n'\
>> /etc/systemd/system/tomcat.service

#--------------------------- Add Jenkins
RUN wget https://get.jenkins.io/war-stable/2.249.1/jenkins.war -O /usr/local/tomcat/webapps/jenkins.war
WORKDIR /usr/local/tomcat/webapps/

# 4. Allow traffic to the port 8080
EXPOSE 8080

CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
