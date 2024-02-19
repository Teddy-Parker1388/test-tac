
node {
  stage("Test"){
sh "echo new TAC"
  sh "echo new thing has been added"
  }
  stage("Tsunami Check"){
sh "tsunami --version"
sh "git branch"
sh "ls -l"
sh "git checkout"
sh "tsunami tac validate"
sh "tsunami tac sync"

  }


}
