
node {
  stage("Test"){
sh "echo new TAC"
  sh "echo new thing has been added"
  }
  stage("Tsunami Check"){
     withCredentials([usernamePassword(credentialsId: 'github-cred', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]){
      sh 'echo "$USERPASS"'
      sh 'echo "$USERNAME"'
      sh '''
         git config --local user.email pteddy17@gmail.com
         git config --local user.name "$USERNAME"



      '''
      sh 'git push origin HEAD'

    }
sh "tsunami --version"
sh "git branch"
sh "ls -l"
sh "git checkout dev"
sh "tsunami tac validate"
sh "tsunami tac sync"

  }


}
