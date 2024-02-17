/*@Library("tsunami_test")_
node {
     stage("INITIALIZE"){
checkout scmGit(branches: [[name: "${env.BRANCH_NAME}"]], extensions: [], userRemoteConfigs: [[credentialsId: 'github-cred', url: 'https://github.com/Teddy-Parker1388/test-tac.git']])
       }
 testJenkins()

}≈

node {
stage("Check current dir"){
checkout([
         $class: 'GitSCM',
         branches: scm.branches,
         doGenerateSubmoduleConfigurations: scm.doGenerateSubmoduleConfigurations,
         extensions: scm.extensions,
         userRemoteConfigs: scm.userRemoteConfigs
    ])
sh "ls -l"
sh "tsunami tac validate"
sh "git remote -v"

}


}

*/


pipeline {
agent any 
     stages {
stage("Checkout"){
steps{
sh "ls -l"
sh "git remote -v"
}
}


     }






}
