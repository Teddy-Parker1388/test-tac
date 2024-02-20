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
     
  
     
     // Check and commit changes
     def changes = sh(script: 'git status --short', returnStdout: true).trim()
     def environments = /^(dev|prod|qa|stage|perf).*/
     if (env.BRANCH_NAME =~ environments) {
         echo "Running `tsunami tac sync`..."
         sh "tsunami tac sync -e ${env.BRANCH_NAME}"
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
