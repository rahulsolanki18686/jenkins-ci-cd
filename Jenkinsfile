pipeline {

    agent any
    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "maven"
    }
    environment{
        APP_NAME = "spring-docker-cicd"
        RELEASE = "1.0.0"
        DOCKER_USER = "rahulsolankis"
        IMAGE_NAME = "${DOCKER_USER}"+"/"+"${APP_NAME}"
        IMAGE_TAG = "${RELEASE_NO}-${BUILD_NUMBER}"

    }
    stages {
        stage('SCM checkout') {
            steps {
                // Get some code from a GitHub repository
               // git branch: 'main', url: 'https://github.com/rahulsolanki18686/jenkins-ci-cd.git'
               checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/rahulsolanki18686/jenkins-ci-cd.git']])



                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }

         stage('MVN Build') {
            steps {
               script {
                   bat "mvn clean install"
                      // Run Maven on a Unix agent.
              //  bat "mvn -Dmaven.test.failure.ignore=true clean package"

                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
               }

            }
        }
       stage("Build Image"){
            steps{
                script{
                    bat 'docker build -t %IMAGE_NAME%:%IMAGE_TAG% .'
                }
            }
        }
        stage("Deploy Image to Hub"){
            steps{
                withCredentials([string(credentialsId: 'dp', variable: 'dp')]) {
                bat 'docker login -u rahulsolankis -p SMeet@134'
                bat 'docker push %IMAGE_NAME%:%IMAGE_TAG%'
                }
            }
        }
    }

    post{
        always{
            emailext attachLog: true, body: '''<html><body>
<p>Build Status: ${BUILD_STATUS}</p>
<p>Build Number: ${BUILD_NUMBER}</p>
<p>Check the <a href="${BUILD_URL}">console output</a></p>
</body></html>''', mimeType: 'text/html', replyTo: 'rahulsolanki.softwaredeveloper@gmail.com', subject: 'pipeline Status: ${BUILD_NUMBER}', to: 'rahulsolanki.softwaredeveloper@gmail.com'
        }
    }

}
