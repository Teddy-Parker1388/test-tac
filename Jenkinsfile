@Library("tsunami_test")_
node {
  def environments = /^(dev|prod|qa|stage|perf).*/
  
  if(env.BRANCH_NAME ==~ environments){
      stage("Test"){
        testJenkins()
  }
      stage("Tsunami Check"){
        sh "tsunami --version"

  }
  }

}
