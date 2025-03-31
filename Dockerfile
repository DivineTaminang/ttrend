FROM openjdk:8
COPY target/demo-workshop-2.1.2.jar ttrend.jar
ENTRYPOINT ["java", "-jar", "ttrend.jar"]



# FROM openjdk:8
# # ADD jarstaging/com/valaxy/demo-workshop/2.1.2/demo-workshop-2.1.2.jar ttrend.jar
# ENTRYPOINT ["java", "-jar", "ttrend.jar"]
