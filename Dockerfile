FROM jboss/base-jdk:7
MAINTAINER Divine chamoh

# Set the JBOSS_VERSION env variable
ENV JBOSS_HOME /opt/jboss/

# Add the JBoss distribution to /opt, and make jboss the owner of the extracted zip content
#me Make sure the distribution is available from a well-known place

RUN curl -o $JBOSS_HOMEjboss-eap-6.1.0.zip https://access.redhat.com/cspdownload/6005f0cceb6dae4d712cd9cb266e9675/5811038e/JBEAP-6.1.0/jboss-eap-6.1.0.zip \
&& jar -xvf $JBOSS_HOMEjboss-eap-6.1.0.zip \
&& chmod a+x /opt/jboss/jboss-eap-6.1/bin/*


# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
#ENV LAUNCH_JBOSS_IN_BACKGROUND true

# Expose the ports we're interested in
# http://stackoverflow.com/a/32213512/1098564
EXPOSE 8080 9990 4447 9999

# Set the default command to run on boot
# This will boot JBoss EAP in the standalone mode and bind to all interface
CMD ["/opt/jboss/jboss-eap-6.1/bin/standalone.sh" ,"-b","0.0.0.0","-bmanagement", "0.0.0.0"]
