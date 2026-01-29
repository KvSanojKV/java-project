pipeline {
    agent any

    tools {
        maven 'maven3'
    }

    environment {
        IMAGE_NAME = "sanojkv/java-app"
        SONAR_HOST = "http://localhost:9000"
    }

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/kvsanojkv/java-project.git'
            }
        }

        stage('Build & Test') {
            steps {
                sh 'mvn clean test'
            }
        }

        stage('Code Quality - SonarQube') {
            steps {
                withSonarQubeEnv('sonarqube-server') {
                    sh '''
                      mvn sonar:sonar \
                      -Dsonar.projectKey=java-app \
                      -Dsonar.host.url=$SONAR_HOST
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

