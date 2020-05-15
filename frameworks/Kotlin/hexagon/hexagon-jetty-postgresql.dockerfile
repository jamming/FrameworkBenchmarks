#
# BUILD
#
FROM gradle:6.4-jdk11 AS gradle_build
USER root
WORKDIR /hexagon

COPY src src
COPY build.gradle build.gradle
COPY gradle.properties gradle.properties
RUN gradle --quiet --exclude-task test

#
# RUNTIME
#
FROM openjdk:11.0.7-jre-slim
ENV DBSTORE postgresql
ENV POSTGRESQL_DB_HOST tfb-database
ENV WEBENGINE jetty
ENV PROJECT hexagon

COPY --from=gradle_build /hexagon/build/install/$PROJECT /opt/$PROJECT
ENTRYPOINT /opt/$PROJECT/bin/$PROJECT
