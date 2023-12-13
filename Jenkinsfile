node {
    def REPOSITORY_CREDENTIAL_ID = 'jenkins-test'
    def REPOSITORY_URL = 'git@github.com:zoosickcompany/jenkins-test.git'
    def TARGET_BRANCH = 'dev'
    def IMAGE_NAME = 'demo'
    def CONTAINER_NAME = 'demo'
    def PROFILE = 'dev'
    def DOCKER_HUB_CREDENTIAL_ID = 'docker-hub'

    stage('init') {
        sh """ docker rm -f $CONTAINER_NAME || true """
        deleteDir()
    }

    stage('clone project') {
        git url: REPOSITORY_URL, branch: TARGET_BRANCH, credentialsId: REPOSITORY_CREDENTIAL_ID
    }

    stage('deploy') {
        withCredentials([usernamePassword(credentialsId: DOCKER_HUB_CREDENTIAL_ID, usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
            sh "docker login -u ${DOCKER_HUB_USERNAME} -p ${DOCKER_HUB_PASSWORD}"
            sh "docker build -t ${DOCKER_HUB_USERNAME}/$IMAGE_NAME:latest -f Dockerfile ."
            sh "docker push ${DOCKER_HUB_USERNAME}/$IMAGE_NAME:latest"

            sh "docker run --name $CONTAINER_NAME -d -p 40000:40000 ${DOCKER_HUB_USERNAME}/$IMAGE_NAME:latest"
        }
    }
}
