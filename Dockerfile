FROM openjdk:17
WORKDIR /app
COPY jarstaging/com/valaxy/demo-workshop/2.1.2 ttrend.jar
ENTRYPOINT ["java", "-jar", "ttrend.jar"]

# ~/jenkins/workspace/multibranch-pipeline_main/target/demo-workshop-2.1.2.jar
# /home/ubuntu/jenkins/workspace/multibranch-pipeline_main/jarstaging/com/valaxy/demo-workshop/2.1.2

# FROM openjdk:8
# COPY target/demo-workshop-2.1.2.jar ttrend.jar
# ENTRYPOINT ["java", "-jar", "ttrend.jar"]



# FROM openjdk:8
# # ADD jarstaging/com/valaxy/demo-workshop/2.1.2/demo-workshop-2.1.2.jar ttrend.jar
# ENTRYPOINT ["java", "-jar", "ttrend.jar"]
