ARG JAVA_VERSION=1.11
ARG GRADLE_VERSION=jdk11

FROM gradle:$GRADLE_VERSION as builder
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon
RUN JAR_FILE=$(ls /home/gradle/src/build/libs/ | grep jar | grep -v plain) && \
    cp /home/gradle/src/build/libs/$JAR_FILE /home/gradle/src/app.jar

FROM registry.access.redhat.com/ubi8/openjdk-11-runtime:$JAVA_VERSION
COPY --from=builder /home/gradle/src/app.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
