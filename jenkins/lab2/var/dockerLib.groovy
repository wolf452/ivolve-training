def buildImage(String imageName, String dockerfilePath = ".") {
    sh "docker build -t ${imageName} ${dockerfilePath}"
}

def pushImage(String imageName, String credentialsId) {
    withCredentials([usernamePassword(credentialsId: credentialsId, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
        sh """
        docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
        docker push ${imageName}
        """
    }
}

def removeLocalImage(String imageName) {
    sh "docker rmi ${imageName} || true"
}
