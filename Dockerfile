FROM ubuntu:latest
LABEL authors="sergio"

FROM openjdk:17-alpine

RUN apk add --no-cache bash
RUN apk --no-cache add curl

# Crear directorio de trabajo
WORKDIR /akka

# Copiar el código fuente al contenedor
COPY . /akka

# Compilar el proyecto
RUN ./sbt clean compile stage

# Exponer puertos
EXPOSE 8080

# Comando de inicio
CMD ["/akka/target/universal/stage/bin/akkahttp"]


