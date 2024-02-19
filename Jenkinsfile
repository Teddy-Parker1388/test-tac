
node {
  stage("Test"){
sh "echo new TAC"
  sh "echo new thing has been added"
  }
  stage("Tsunami Check"){
     withCredentials([usernameColonPassword(credentialsId: 'github-cred', variable: 'USERPASS')]){
      sh 'echo "$USERNAME"'

    }
sh "tsunami --version"
sh "git branch"
sh "ls -l"
sh "git checkout dev"
sh "tsunami tac validate"
sh "tsunami tac sync"

  }


}
