
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
    echo ${scm.userRemoteConfigs}



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
                    git push origin ${env.BRANCH_NAME}
                """
            } else {
                echo "No changes detected. Skipping commit."
            }

  }
  stage("Tsunami TAC Validate"){
    sh "tsunami tac validate"
  }

}
