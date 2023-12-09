def app

node {
    stage('Checkout') {
        git branch: 'dev', credentialsId: 'jenkins-test', url: 'git@github.com:zoosickcompany/jenkins-test.git'
    }

    stage('Ready') {
        echo 'Ready to build'
        gradleHome = tool 'gradle'
    }

    stage('Build') {
        sh "${gradleHome}/bin/gradle clean build"
    }

    stage('Build image') {
        app = docker.build('sool/jenkins-test')
    }
    stage('Run container') {
        sh "docker run --name sool-jenkins -d -p 40000:40000 sool/jenkins-test:latest"
    }
}