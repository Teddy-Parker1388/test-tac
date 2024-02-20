node {
  stage('Checkout'){
    checkout([
        $class: 'GitSCM',
        branches: scm.branches,
        extensions: scm.extensions,
        userRemoteConfigs: scm.userRemoteConfigs
    ])

    sh """
    git remote -v
    git branch



    """
  }
  stage("Tsunami Setup"){
    sh "tsunami --version"
    sh "python3 -m pip list"
  }
  stage("Tsunami TAC Sync"){
   sh "tsunami tac sync -e ${env.BRANCH_NAME}"
   sh "touch newfile.txt"
   def changes = sh(script: 'git status --porcelain', returnStdout: true).trim()
   if (changes) {
                // There are changes, commit them
                sh """
                    git add .
                    git commit -m 'Changes made after running TAC Sync'
                    
                """
     script{
     git push origin dev}
              withCredentials([usernamePassword(credentialsId: 'github-cred', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD')]) {
    sh """
    git config --global user.name ${GIT_USERNAME}
    git config --global user.password ${GIT_PASSWORD}
    git push --set-upstream origin ${env.BRANCH_NAME}
    """
}
     
            } else {
                echo "No changes detected. Skipping commit."
            }

  }
  stage("Tsunami TAC Validate"){
    sh "tsunami tac validate"
  }

}

