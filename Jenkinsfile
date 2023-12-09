def app

node {
    stage('Checkout') {
        checkout scm
    }

    stage('Ready') {
        echo 'Ready to build'
        gradleHome = tool 'jenkins-gradle'
    }

    stage('Build') {
        sh "${gradleHome}/bin/gradle clean build"
    }

    stage('Build image') {
        script {
            // Docker Hub에 로그인
            withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
                sh "/home/oslob/snap/docker build -t sool/jenkins-test -f Dockerfile ."
            }
        }
    }

    stage('Run container') {
        sh "docker run --name sool-jenkins -d -p 40000:40000 sool/jenkins-test:latest"
    }
}
