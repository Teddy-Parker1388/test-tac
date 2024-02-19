
node {
  stage("Test"){
sh "echo new TAC"
  sh "echo new thing has been added"
  }
  stage("Tsunami Check"){
     withCredentials([usernamePassword(credentialsId: 'github-cred', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]){
      sh 'echo "$USERPASS"'
      sh 'echo "$USERNAME"'
      git credentialsId: 'github-cred', url: 'https://github.com/Teddy-Parker1388/test-tac.git'
      sh 'git push origin dev'

    }
sh "tsunami --version"
sh "git branch"
sh "ls -l"
sh "git checkout dev"
sh "tsunami tac validate"
sh "tsunami tac sync"

  }


}
