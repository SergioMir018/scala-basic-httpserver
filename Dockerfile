FROM ubuntu:latest
LABEL authors="sergio"

FROM openjdk:17-alpine

RUN apk --no-cache add bash curl

# Instalación de Scala y sbt
ENV SCALA_VERSION 2.12.4
ENV SBT_VERSION 1.5.5
RUN apk --no-cache add bash curl && \
    curl -L -o sbt-$SBT_VERSION.tgz https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz && \
    tar -zxvf sbt-$SBT_VERSION.tgz -C /usr/local && \
    rm sbt-$SBT_VERSION.tgz && \
    ln -s /usr/local/sbt/bin/sbt /usr/local/bin/sbt

# Crear directorio de trabajo
WORKDIR /akka

# Copiar el código fuente al contenedor
COPY . /akka

# Compilar el proyecto
RUN sbt clean compile stage

# Exponer puertos
EXPOSE 8080

# Comando de inicio
CMD ["/akka/target/universal/stage/bin/akkahttp"]
