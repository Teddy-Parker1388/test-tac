node {
stage("Checkout"){
    checkout([
        $class: 'GitSCM',
        branches: scm.branches,
        extensions: scm.extensions,
        userRemoteConfigs: scm.userRemoteConfigs
    ])

}
sh """
     ls -l
     git branch 
"""


}

