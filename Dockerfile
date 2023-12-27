FROM ubuntu:latest
LABEL authors="sergio"

ENTRYPOINT ["top", "-b"]

# Usamos una imagen base con Java y SBT instalados
FROM adoptopenjdk:11-jre-hotspot

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiamos los archivos necesarios al contenedor
COPY . .

# Compilamos el proyecto (puedes ajustar los comandos según tu proyecto)
RUN sbt compile

# Comando para ejecutar la aplicación
CMD ["sbt", "run"]
