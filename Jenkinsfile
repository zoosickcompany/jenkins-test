def app

node {

    stage('Ready') {
        echo 'Ready to build'
        gradleHome = tool 'jenkins-gradle'
    }

    stage('Build') {
        sh "${gradleHome}/bin/gradle clean build"
    }

    stage('Build image') {
        sh "/usr/bin/docker build -t sool/jenkins-test ."
    }
    stage('Run container') {
        sh "docker run --name sool-jenkins -d -p 40000:40000 sool/jenkins-test:latest"
    }
}