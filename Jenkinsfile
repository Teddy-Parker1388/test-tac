node {
stage("Checkout"){
    checkout([
        $class: 'GitSCM',
        branches: scm.branches,
        extensions: scm.extensions,
        userRemoteConfigs: scm.userRemoteConfigs
    ])

}
 stage("Tsunami Sync"){
     echo "Running `tsunami tac sync`..."
     sh "tsunami tac sync -e ${env.BRANCH_NAME}"
     
     // Check and commit changes
     def changes = sh(script: 'git status --short', returnStdout: true).trim()
     def environments = /^(dev|prod|qa|stage|perf).*/
     if (env.BRANCH_NAME =~ environments) {
     if (changes) {
                // There are changes, commit them.
        sh """
            git add .
            git commit -m 'Changes made after running TAC Sync'
            """

         }else{
       echo "There are no changes to commit"
     }
}
 }
    stage("Check Stuff"){
        
sh "ls -l"
    }

}






/*node {
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
   sh "tsunami tac sync -e ${env.BRANCH_NAME}"
   sh "touch newfile.txt"
   def changes = sh(script: 'git status --porcelain', returnStdout: true).trim()
   if (changes) {
                // There are changes, commit them
                sh """
                    git add .
                    git commit -m 'Changes made after running TAC Sync'
                    
                """
              withCredentials([sshUserPrivateKey(credentialsId: 'github-ssh', keyFileVariable: 'privateKey', usernameVariable: 'GIT_USERNAME')]) {
    sh """
    git checkout ${env.BRANCH_NAME}
    git config --global user.name ${GIT_USERNAME}
    git config --global user.email pteddy17@gmail.com
    echo "I love coding" >> secondfile.txt
    git add .
    git commit -m 'Yes second file'
    git remote set-url origin git@github.com:Teddy-Parker1388/test-tac.git
    git pull origin ${env.BRANCH_NAME}
    git push origin ${env.BRANCH_NAME}
    """
}
     
     
            } else {
                echo "No changes detected. Skipping commit."
            }

  }
  stage("Tsunami TAC Validate"){
    sh "tsunami tac validate"
  }

}*/

