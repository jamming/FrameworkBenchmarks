FROM gradle:4.7.0-jdk10
USER root
WORKDIR /hexagon
COPY src src
COPY build.gradle build.gradle
COPY gradle.properties gradle.properties
COPY settings.gradle settings.gradle
RUN gradle --quiet --exclude-task test
ENV DBSTORE postgresql
ENV WEBENGINE jetty
CMD ["build/install/hexagon/bin/hexagon"]
