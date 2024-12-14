def checkoutRepository(String repoUrl, String branch = 'main', String subDir = '') {
    if (subDir) {
        dir(subDir) {
            git url: repoUrl, branch: branch
        }
    } else {
        git url: repoUrl, branch: branch
    }
}
