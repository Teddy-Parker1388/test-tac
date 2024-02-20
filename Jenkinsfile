
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
   sh "tsunami tac sync -e dev"

  }
  stage("Tsunami TAC Validate"){
    sh "tsunami tac validate"
  }

}
