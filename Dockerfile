FROM maven:3.6.2-jdk-8-openj9 AS build

WORKDIR /src
COPY pom.xml /src/pom.xml
RUN mvn dependency:resolve

COPY src /src/src
RUN mvn clean package

FROM sonatype/nexus3:3.19.1

COPY --from=build /src/target/nexus-blobstore-azure-cloud-0.4.0-SNAPSHOT.jar /opt/sonatype/nexus/deploy
