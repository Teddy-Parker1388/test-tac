@Library("tsunami_test")_
node {
     stage("INITIALIZE"){
checkout scm
          sh "git checkout ${env.BRANCH_NAME}"
       }
 testJenkins()

}
