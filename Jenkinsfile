
node {
  stage("Test"){
sh "echo new TAC"
  sh "echo new thing has been added"
  }
  stage("Tsunami Check"){
     withCredentials([usernamePassword(credentialsId: 'github-cred', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]){
      sh 'echo "$USERPASS"'
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
