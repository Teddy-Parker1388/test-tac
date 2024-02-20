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
              withCredentials([sshUserPrivateKey(credentialsId: 'github-ssh', keyFileVariable: 'privateKey', usernameVariable: 'GIT_USERNAME')]) {
    sh """
    git config --global user.name ${GIT_USERNAME}
    git config --global user.email pteddy17@gmail.com
    git remote set-url origin git@github.com:Teddy-Parker1388/test-tac.git
    git pull origin ${env.BRANCH_NAME}
    git push origin ${env.BRANCH_NAME}
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

