FROM svn.co811.org:5000/co811-java:latest
MAINTAINER D. J. Hagberg <dhagberg@millibits.com>

ENV CATALINA_HOME /usr/local/tomcat
ENV TOMCAT_VERS=8.5.57
ENV TOMCAT_SHA5=720de36bb3e40a4c67bdf0137b12ae0fd733aef772d81a4b8dab00f29924ddd17ecb2a7217b9551fc0ca51bd81d1da13ad63b6694c445e5c0e42dfa7f279ede1
ENV TINI_VERS=0.19.0
ENV TINI_SHA5=3de06fb0a8a1fdc06f48c1933b474c965242292a02b8fa0bb85fe90678c33bb35962ab239dd7000f8bcae841045d6660bbd6846414b0a07982c4dbfb2c2bd1cc
ENV PATH $CATALINA_HOME/bin:$PATH

COPY build/ /root/build/
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

RUN /root/build/build_tomcat85 $BUILDTS

USER tomcat
EXPOSE 8080
CMD exec /usr/bin/tini $CATALINA_HOME/bin/catalina.sh run
