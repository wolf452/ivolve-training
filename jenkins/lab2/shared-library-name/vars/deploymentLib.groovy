def editDeploymentYaml(String yamlFile, String dockerImage) {
    sh "sed -i 's|image:.*|image: ${dockerImage}|g' ${yamlFile}"
}
