pipeline {
    agent any

    environment {
        IMAGE_NAME = 'haritharavichandran/my-go-app'
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub-creds') // Jenkins credentials ID
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/YOUR_USERNAME/YOUR_REPO.git'
            }
        }

        stage('Test') {
            steps {
                sh 'go test ./...'
            }
        }

        stage('Lint Dockerfile') {
            steps {
                sh 'docker run --rm -i hadolint/hadolint < Dockerfile'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Push to DockerHub') {
            steps {
                sh """
                    echo "${DOCKER_HUB_CREDENTIALS_PSW}" | docker login -u "${DOCKER_HUB_CREDENTIALS_USR}" --password-stdin
                    docker push ${IMAGE_NAME}:latest
                """
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                sh 'docker-compose down || true'
                sh 'docker-compose up -d'
            }
        }
    }
}
