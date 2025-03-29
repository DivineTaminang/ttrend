  def registry = 'https://trialhbh694.jfrog.io'
  def imageName = 'mavine-docker-local/ttrend'
  def version = '2.1.2'
     environment {
            PATH: "/home/ubuntu/apache-maven-3.9.9/bin:$PATH"
          }
  pipeline {
        agent {
           node {
               label 'slave-server' 
           }
        }
        stages {
           stage("source code check out") {
            steps {
              checkout scm   
            }
          }
           stage("maven build") {
            steps {
             sh "mvn clean deploy"             

            }
          }
        
        
        //   stage("build & SonarQube analysis") {
        //     agent any
        //     steps {
        //       withSonarQubeEnv('sonarqube') {
        //         sh 'mvn clean package sonar:sonar'
        //       }
        //     }
        //   }
        //  stage("Quality Gate") {
        //     steps {
        //       timeout(time: 1, unit: 'HOURS') {
        //         waitForQualityGate abortPipeline: true
        //       }
        //     }
        //   }
        //  stage("Jar Publish") {
        //     steps {
        //      script {
        //             echo '<--------------- Jar Publish Started --------------->'
        //              def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"artifact-cred"
        //              def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
        //              def uploadSpec = """{
        //                   "files": [
        //                     {
        //                       "pattern": "jarstaging/(*)",
        //                       "target": "libs-release-local/{1}",
        //                       "flat": "false",
        //                       "props" : "${properties}",
        //                       "exclusions": [ "*.sha1", "*.md5"]
        //                     }
        //                  ]
        //              }"""
        //              def buildInfo = server.upload(uploadSpec)
        //              buildInfo.env.collect()
        //              server.publishBuildInfo(buildInfo)
        //              echo '<--------------- Jar Published Ended --------------->'  
            
         
        // }
      }
  }