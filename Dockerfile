FROM ubuntu:latest
LABEL authors="sergio"

FROM openjdk:17-alpine

# Instalación de Scala
ENV SCALA_VERSION 2.12.4
RUN apk add --no-cache bash
RUN apk --no-cache add curl
RUN mkdir /usr/local/scala
RUN curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /usr/local/scala/
ENV PATH="/usr/local/scala/scala-$SCALA_VERSION/bin:${PATH}"

# Configuración del directorio de trabajo
WORKDIR /akka

# Copiar archivos necesarios al contenedor
COPY ./target/universal/stage/ /akka/

# Exponer puertos
EXPOSE 8080

# Comando de inicio
CMD ["/akka/bin/akkahttp"]

