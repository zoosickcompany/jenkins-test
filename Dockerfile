node {
    // Define environment variables
    def REPOSITORY_CREDENTIAL_ID = 'jenkins-test' // github repository credential name
    def REPOSITORY_URL = 'git@github.com:zoosickcompany/jenkins-test.git'
    def TARGET_BRANCH = 'dev'
    def IMAGE_NAME = 'demo'
    def CONTAINER_NAME = 'demo'
    def PROFILE = 'dev'
    def DOCKER_HUB_CREDENTIAL_ID = 'docker-hub' // Docker Hub credentials ID

    // Init stage
    stage('init') {
        echo 'init stage'
        try {
            sh "docker rm -f $CONTAINER_NAME || true"
        } finally {
            deleteDir()
        }
    }

    stage('clone project') {
        steps {
            script {
                checkout([$class: 'GitSCM', branches: [[name: "*/$TARGET_BRANCH"]], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: REPOSITORY_CREDENTIAL_ID, url: REPOSITORY_URL]]])
                sh 'ls -al'
            }
        }
    }


    // Dockerizing by Gradle stage
    stage('dockerizing by Gradle') {
        sh "./gradlew bootBuildImage -PskipTests -PimageName=$IMAGE_NAME"
    }

    // Deploy stage
    stage('deploy') {
        // Docker Hub login
        withCredentials([usernamePassword(credentialsId: DOCKER_HUB_CREDENTIAL_ID, usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
            sh "docker login -u $DOCKER_HUB_USERNAME -p $DOCKER_HUB_PASSWORD"

            // Docker image build and push
            sh "docker build -t ${DOCKER_HUB_USERNAME}/$IMAGE_NAME:latest -f Dockerfile ."
            sh "docker push ${DOCKER_HUB_USERNAME}/$IMAGE_NAME:latest"
        }

        // Run container using the image
        sh "docker run --name $CONTAINER_NAME -d -p 40000:40000 ${DOCKER_HUB_USERNAME}/$IMAGE_NAME:latest"
    }
}
