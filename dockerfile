    FROM java:8
    
    RUN echo "deb [check-valid-until=no] http://cdn-fastly.deb.debian.org/debian jessie main" > /etc/apt/sources.list.d/jessie.list
    RUN echo "deb [check-valid-until=no] http://archive.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list
    RUN sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list
    RUN sudo apt-get -o Acquire::Check-Valid-Until=false update
    RUN echo 'Acquire::Check-Valid-Until no;' > /etc/apt/apt.conf.d/99no-check-valid-until
    
    RUN apt-get update 
    RUN apt-get install -y maven

    WORKDIR /code
    ADD pom.xml /code/pom.xml
    ADD src/main/webapp/WEB-INF/web.xml /codes/rc/main/webapp/WEB-INF/web.xml
    RUN ["mvn", "dependency:resolve"]

    ADD src /code/src
    RUN ["mvn", "package"]
    CMD ["usr/lib/jvm/java-8-openjdk-amd64/bin/java", "-war", "target/demo.war"]
