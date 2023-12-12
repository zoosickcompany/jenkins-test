def app

environment{
    REPOSITORY_CREDENTIAL_ID = 'jenkins-test' // github repository credential name
    REPOSITORY_URL = 'git@github.com:zoosickcompany/jenkins-test.git'
    DOCKER_HUB_CREDENTIAL_ID = 'docker-hub' // Docker Hub credentials ID
}

node {
    stage('Ready') {      
        sh "./gradlew bootBuildImage -PskipTests -PimageName=test"
    }

    stage('Build') {
        sh "${gradleHome}/bin/gradle clean build"
        sh "docker build -t test:latest -f Dockerfile ."
    }
 
    stage('Build image') {
        app = docker.build('zoosickcompany/jenkins-test')
    }
}
