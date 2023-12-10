pipeline {
    agent any

    options {
        timeout(time: 1, unit: 'HOURS') // set timeout 1 hour
    }

    environment {
        REPOSITORY_CREDENTIAL_ID = 'jenkins-test' // github repository credential name
        REPOSITORY_URL = 'git@github.com:zoosickcompany/jenkins-test.git'
        TARGET_BRANCH = 'dev'
        IMAGE_NAME = 'demo'
        CONTAINER_NAME = 'demo'
        PROFILE = 'dev'
        DOCKER_HUB_CREDENTIAL_ID = 'docker-hub' // Docker Hub credentials ID
    }

    stages {
        stage('init') {
            steps {
                echo 'init stage'
                script {
                    // Use double quotes to allow variable interpolation
                    sh """
                    docker rm -f $CONTAINER_NAME || true
                    """
                    deleteDir()
                }
            }
            post {
                success {
                    echo 'success init in pipeline'
                }
            }
        }

        stage('clone project') {
            steps {
                script {
                    git url: REPOSITORY_URL,
                        branch: TARGET_BRANCH,
                        credentialsId: REPOSITORY_CREDENTIAL_ID
                    sh 'ls -al'
                }
            }
            post {
                success {
                    echo 'success clone project'
                }
                failure {
                    error 'fail clone project' // exit pipeline
                }
            }
        }

        stage('dockerizing by Gradle') {
    steps {
        script {
            sh './gradlew bootBuildImage -PskipTests -PimageName=$IMAGE_NAME'
        }
    }
    post {
        success {
            echo 'success dockerizing by Gradle'
        }
        failure {
            error 'fail dockerizing by Gradle' // exit pipeline
        }
    }
}

stage('deploy') {
    steps {
        script {
            // Docker Hub에 로그인
            withCredentials([usernamePassword(credentialsId: DOCKER_HUB_CREDENTIAL_ID, usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
                // Docker 이미지를 Docker Hub에 푸시 (태그 추가)
                sh """ which docker
                       docker --version
                       docker build -t ${DOCKER_HUB_USERNAME}/$IMAGE_NAME:latest -f Dockerfile .
                   """ // 사용자 이름을 이미지 이름에 포함
                sh "docker push ${DOCKER_HUB_USERNAME}/$IMAGE_NAME:latest"
            }

            // 이미지를 사용하여 컨테이너 실행
            sh "docker run --name $CONTAINER_NAME -d -p 40000:40000 demo:0.0.1-SNAPSHOT"
        }
    }
    post {
        success {
            echo 'success deploying sool spring project'
        }
        failure {
            error 'fail deploying sool spring project' // exit pipeline
        }
    }
}


    }
}