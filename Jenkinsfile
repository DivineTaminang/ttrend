  def registry = 'https://trialhbh694.jfrog.io'
  def imageName = 'mavine-docker-local/ttrend'
  def version = '2.1.2'
  pipeline {
        agent {
           node {
               label 'slave-server' 
           }
        }
          environment {
            PATH= "/opt/apache-maven-3.9.9/bin:$PATH"
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
           stage('unit test') {
            steps {
                echo "-------unit test started------"
                sh 'mvn surefire-report:report'
                echo "-------unit test ended------"
            }
        }

        
        
          // stage("build & SonarQube analysis") {
          //   agent any
          //   steps {
          //     withSonarQubeEnv('sonarqube') {
          //       sh 'mvn clean package sonar:sonar'
          //     }
          //   }


           stage("SonarQube analysis") {
            environment {
                scannerHome = tool 'sonar-scanner'
            }
            steps {
                withSonarQubeEnv("mavine-sonarqube-server") {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }


       }
        //  stage("Quality Gate") {
        //     steps {
        //       timeout(time: 1, unit: 'HOURS') {
        //         waitForQualityGate abortPipeline: true
        //       }
        //     }
        //   }
         stage("Jar Publish") {
            steps {
             script {
                    echo '<--------------- Jar Publish Started --------------->'
                     def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"jfrog-creds"
                     def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                     def uploadSpec = """{
                          "files": [
                            {
                              "pattern": "jarstaging/(*)",
                              "target": "libs-release-local/{1}",
                              "flat": "false",
                              "props" : "${properties}",
                              "exclusions": [ "*.sha1", "*.md5"]
                            }
                         ]
                     }"""
                     def buildInfo = server.upload(uploadSpec)
                     buildInfo.env.collect()
                     server.publishBuildInfo(buildInfo)
                     echo '<--------------- Jar Published Ended --------------->'  
            
         
        }
      }
  }
  }