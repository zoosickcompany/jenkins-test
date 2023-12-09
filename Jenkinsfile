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
            // Docker 실행 파일의 전체 경로를 사용합니다.
            sh "/usr/bin/docker build -t sool/jenkins-test -f Dockerfile ."
        }
    }

    stage('Run container') {
        sh "docker run --name sool-jenkins -d -p 40000:40000 sool/jenkins-test:latest"
    }
}