pipeline {
    agent any

    environment {
        IMAGE_NAME = 'haritharavichandran/my-go-app'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Haritha200111/Web-App.git'
            }
        }

        stage('Test') {
            steps {
                bat 'go test ./...'
            }
        }

        stage('Lint Dockerfile') {
            steps {
                bat 'docker run --rm -i hadolint/hadolint < Dockerfile'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t %IMAGE_NAME%:latest ."
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_HUB_CREDENTIALS_USR', passwordVariable: 'DOCKER_HUB_CREDENTIALS_PSW')]) {
                    bat """
                        echo %DOCKER_HUB_CREDENTIALS_PSW% | docker login -u %DOCKER_HUB_CREDENTIALS_USR% --password-stdin
                        docker push %IMAGE_NAME%:latest
                    """
                }
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                bat 'docker-compose down || exit 0'  // handle failure gracefully on Windows
                bat 'docker-compose up -d'
            }
        }
    }
}
