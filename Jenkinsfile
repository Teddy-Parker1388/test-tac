node {
  def environments = /^(dev|prod|qa|stage|perf).*/
  
  if(env.BRANCH_NAME ==~ environments){
      stage("Test"){
        sh "echo new TAC"
  }
      stage("Tsunami Check"){
        sh "tsunami --version"

  }
  }

}
