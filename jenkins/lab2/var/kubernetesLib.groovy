def applyManifest(String kubeConfigPath, String token, String yamlFile, String namespace) {
    sh """
    kubectl --kubeconfig=${kubeConfigPath} --token=${token} apply -f ${yamlFile} -n ${namespace}
    """
}

def deleteDeployment(String kubeConfigPath, String token, String deploymentName, String namespace) {
    sh """
    kubectl --kubeconfig=${kubeConfigPath} --token=${token} delete deployment ${deploymentName} -n ${namespace} || true
    """
}

def checkDeploymentStatus(String kubeConfigPath, String token, String deploymentName, String namespace) {
    sh """
    kubectl --kubeconfig=${kubeConfigPath} --token=${token} rollout status deployment/${deploymentName} -n ${namespace}
    """
}
