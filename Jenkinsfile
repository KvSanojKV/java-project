pipeline {
    agent any

    tools {
        maven 'maven3'
    }

    environment {
        IMAGE_NAME = "sanojkv/java-app"
        SONAR_HOST = "http://192.168.152.128:9000"
    }

    stages {
          
        

        stage('Build & Test') {
            steps {
                sh 'mvn clean test'
            }
        }

        stage('Code Quality - SonarQube') {
         steps {
           withCredentials([string(credentialsId: 'sonar-token', variable: 'SONAR_TOKEN')]) {
            sh '''
              mvn org.sonarsource.scanner.maven:sonar-maven-plugin:4.0.0.4121:sonar \
              -Dsonar.projectKey=java-app \
              -Dsonar.projectName=java-app \
              -Dsonar.host.url=http://192.168.152.128:9000 \
              -Dsonar.login=$SONAR_TOKEN
            '''
        }
    }
}

        stage('Build Package') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:latest .'
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-credentials', variable: 'DOCKER_TOKEN')]) {
                    sh 'echo $DOCKER_TOKEN | docker login -u your_dockerhub_user --password-stdin'
                    sh 'docker push $IMAGE_NAME:latest'
                }
            }
        }
    }
}

