def app

environment {
    REPOSITORY_CREDENTIAL_ID = 'jenkins-test' // github repository credential name
    DOCKER_HUB_CREDENTIAL_ID = 'docker-hub' // Docker Hub credentials ID
}

pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm 
            }
        }

        stage('Ready') {
            steps {
                script {
                    echo 'Ready to build'
                    gradleHome = tool 'gradle' 
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    sh "docker build -t test:latest -f Dockerfile ."
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    app = docker.build('zoosickcompany/jenkins-test')
                    // Push the Docker image to a registry (replace 'your-docker-registry' with the actual registry)
                    docker.withRegistry('https://your-docker-registry', 'your-docker-credentials-id') {
                        app.push()
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up by removing the Docker image created during the build
            script {
                app.remove()
            }
        }
    }
}
