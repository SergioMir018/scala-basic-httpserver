FROM ubuntu:latest
LABEL authors="sergio"

ENTRYPOINT ["top", "-b"]

FROM openjdk:8u151

# Env variables
ENV SCALA_VERSION 2.12.4
ENV SBT_VERSION 1.1.1

# Scala expects this file
RUN touch /usr/lib/jvm/java-8-openjdk-amd64/release

# Install Scala
# Piping curl directly in tar
RUN \
  curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ && \
  echo >> /root/.bashrc && \
  echo "export PATH=~/scala-$SCALA_VERSION/bin:$PATH" >> /root/.bashrc

# Mk app dir
RUN mkdir /alor

# Define working directory
WORKDIR /alor

# Add target packaged app
COPY target/universal/stage/ /alor/

# Expose ports
EXPOSE 800
EXPOSE 5150

# Launch the app
CMD ./bin/alor
