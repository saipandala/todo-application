pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "saipandala/todo-application"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', credentialsId: 'github-credentials', url: 'https://github.com/saipandala/todo-application.git'
            }
        }
        stage('Build') {
            steps {
                sh "mvn clean package -DskipTests"
            }
        }
        stage('Docker Build and Push') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials'){
                        sh 'docker build -t ${DOCKER_IMAGE}:latest .'
                        sh 'docker push ${DOCKER_IMAGE}:latest'
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                sh 'docker compose down --remove-orphans'
               // sh 'docker rm -f mysql-db || true'
              //  sh 'docker compose up -d'
            }
        }
        stage('cleanup') {
            steps {
                sh 'rm -rf *'
            }
        }
    }      
}
