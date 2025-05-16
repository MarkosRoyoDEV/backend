# Usa una imagen con JDK y Maven para construir el proyecto
FROM maven:3.9.4-eclipse-temurin-21 AS build

# Carpeta de trabajo dentro del contenedor
WORKDIR /app

# Copia los archivos de Maven para hacer cache de dependencias
COPY pom.xml .

# Descarga las dependencias (solo si cambian pom.xml)
RUN mvn dependency:go-offline

# Copia todo el código fuente
COPY src ./src

# Compila y empaqueta el proyecto (sin tests para acelerar)
RUN mvn clean package -DskipTests

# Segunda etapa: imagen más liviana solo con JRE para ejecutar
FROM eclipse-temurin:21-jre

WORKDIR /app

# Copia el jar construido desde la etapa de build
COPY --from=build /app/target/backend-0.0.1-SNAPSHOT.jar ./backend.jar

# Expone el puerto (ajusta si usas otro)
EXPOSE 8080

# Comando para ejecutar la app
ENTRYPOINT ["java", "-jar", "backend.jar"]
