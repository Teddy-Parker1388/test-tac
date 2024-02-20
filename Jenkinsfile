
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
  }
  stage("Tsunami TAC Sync"){
   sh "tsunami tac sync"

  }
  stage("Tsunami TAC Validate"){
    sh "tsunami tac validate"
  }

}
