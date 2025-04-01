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


        //    stage("SonarQube analysis") {
        //     environment {
        //         scannerHome = tool 'sonar-scanner'
        //     }
        //     steps {
        //         withSonarQubeEnv("sonarqube") {
        //             sh "${scannerHome}/bin/sonar-scanner"
        //         }
        //     }
        // }


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
                    def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"jfrogcreds-id"
                    def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                    def uploadSpec = """{
                          "files": [
                            {
                              "pattern": "jarstaging/(*)",
                              "target": "mavine-libs-release-local/{1}",
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

        stage("Docker Build") {
          
            steps {
                script {
                    echo '<------------- Docker Build is Started ------------>'
                    app = docker.build(imageName + ":" + version, ".")
                    // app = sh 'docker build -t (imageName + ":" + version)

                    echo '<--------------- Docker Build Ends --------------->'
                }
            }
        }
      
        stage("Docker Published") {
            steps {
                script {
                    docker.withRegistry(registry, 'jfrogcreds-id') {
                        app.push()
                    }
                    echo '<----------- Docker Publish Ended ---------------->'
                }
            }
        }

          //  stage("Docker Build") {
          //   steps {
          //       script {
          //           echo '<------------- Docker Build is Started ------------>'
          //           // sh "docker build -t ${Name}:${version} ."
          //           sh "docker build -t ${imageName}:${version} ."
          //           echo '<--------------- Docker Build Ends --------------->'
          //       }
          //   }
          // }


  //   stage("Docker Publish") {
  //           steps {
  //               script {
  //                   echo '<-------------- Docker Publish Started ------------>'
                    
  //                   withCredentials([usernamePassword(credentialsId: 'jfrogcreds-id', usernameVariable: 'JFROG_USER', passwordVariable: 'JFROG_PASSWORD')]) {
  //                       sh "docker login trialhbh694.jfrog.io -u ${JFROG_USER} -p ${JFROG_PASSWORD}"
  //                        sh "docker tag ${imageName}:${version} trialhbh694.jfrog.io/${imageName}:${version}"
  //                        sh "docker push trialhbh694.jfrog.io/${imageName}:${version}"
  //                   }    

  //                   echo '<-------------- Docker Publish Ended ------------->'
  //            }
  //        }
  //   }
  //       }
  // }
//      stage("Docker Build") {
//             steps {
//                 script {
//                     echo '<------------- Docker Build is Started ------------>'
//                     // Build the image locally as "ttrend:2.1.2"
//                     sh "docker build -t ttrend:2.1.2 ."
//                     echo '<--------------- Docker Build Ends --------------->'
//                 }
//             }
//         }
//         stage("Docker Publish") {
//             steps {
//                 script {
//                     echo '<------------- Docker Publish Started ------------>'
//                     // Log in to the JFrog Docker registry using provided credentials
//                     withCredentials([usernamePassword(credentialsId: 'jfrogcreds-id', usernameVariable: 'JFROG_USER', passwordVariable: 'JFROG_PASSWORD')]) {
//                         sh "docker login trialhbh694.jfrog.io -u ${JFROG_USER} -p ${JFROG_PASSWORD}"
//                         // Tag the locally built image with the full JFrog registry name.
//                         sh "docker tag ttrend:2.1.2 trialhbh694.jfrog.io/ttrend:2.1.2"
//                         // Push the tagged image to JFrog Artifactory.
//                         sh "docker push trialhbh694.jfrog.io/ttrend:2.1.2"
//                     }
//                     echo '<------------- Docker Publish Ended ------------>'
//                 }
//             }
//         }
//     }
// }




        // stage("Kubernetes Deploy") {
        //     steps {
        //         script {
        //             echo '< ------------Kubernetes deploy started ----------------->'
        //             sh './deploy.sh'
        //             echo '< -------------Kubernetes deploy ended ------------------->'
        //         }
        //     }
        // }

        // stage("Deploy") {
        //     steps {
        //         script {
        //             echo '< ------------Helm deploy started ----------------->'
        //             sh 'helm install ttrend ttrend-0.1.0.tgz'
        //             echo '< -------------Helm deploy ended ------------------->'
        //         }
        //   }
        // }
  //   }
}
  }