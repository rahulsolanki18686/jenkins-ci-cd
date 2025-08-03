FROM openjdk:17
COPY ./target/jenkinsCiCd.jar /appContainer
EXPOSE 8282
CMD ["java","-jar","jenkinsCiCd.jar"]