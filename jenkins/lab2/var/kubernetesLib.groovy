def deployToKubernetes(String kubeConfigPath, String token, String yamlFile, String namespace) {
    sh """
    kubectl --kubeconfig=${kubeConfigPath} --token=${token} apply -f ${yamlFile} -n ${namespace}
    """
}
