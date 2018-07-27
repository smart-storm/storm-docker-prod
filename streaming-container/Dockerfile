FROM alpine/git as alpine

WORKDIR /
RUN git clone https://github.com/smart-storm/storm-streaming

FROM maven:latest as maven

COPY --from=alpine /storm-streaming /opt/data
COPY Config.scala /opt/data/src/main/scala/com/smartstorm/
WORKDIR /opt/data
RUN mvn install && mvn package

FROM java:8
EXPOSE 8080

COPY --from=maven /opt/data/target/storm-streaming-1.0-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]