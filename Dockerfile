ARG JAVA_VERSION=11
ARG GRADLE_VERSION=jdk11

FROM gradle:$GRADLE_VERSION as builder
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon
RUN JAR_FILE=$(ls /home/gradle/src/build/libs/ | grep jar | grep -v plain) && cp /home/gradle/src/build/libs/$JAR_FILE /home/gradle/src/app.jar

FROM default-route-openshift-image-registry.apps.cluster-3adc.3adc.sandbox1837.opentlc.com/openshift/java:$JAVA_VERSION
COPY --from=builder /home/gradle/src/app.jar /deployments/
CMD /usr/local/s2i/run