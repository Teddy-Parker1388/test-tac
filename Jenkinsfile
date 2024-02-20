
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
   def changes = sh(script: 'git status --porcelain', returnStdout: true).trim()
   if (changes) {
                // There are changes, commit them
                sh '''
                    git add .
                    git commit -m "Changes made after running TAC Sync"
                '''
            } else {
                echo "No changes detected. Skipping commit."
            }

  }
  stage("Tsunami TAC Validate"){
    sh "tsunami tac validate"
  }

}
