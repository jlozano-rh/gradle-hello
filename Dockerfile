ARG JAVA_VERSION=11

FROM fabric8/s2i-java:latest as builder
USER root
COPY . /tmp/src
RUN chown -R 1000:0 /tmp/src
USER 1000
RUN /usr/local/s2i/assemble
RUN JAR_FILE=$(ls /deployments/ | grep jar | grep -v plain) && cp /deployments/$JAR_FILE /deployments/app.jar

FROM default-route-openshift-image-registry.apps.cluster-3adc.3adc.sandbox1837.opentlc.com/openshift/java:$JAVA_VERSION
COPY --from=builder /deployments/app.jar /deployments/
CMD /usr/local/s2i/run
